import { Component, Inject, Input, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { finalize, first, map } from 'rxjs/operators';
import { CommonService } from 'src/app/common/common/common.service';
import { ClubListPlayerClub } from 'src/app/models/club-list-player-club.model';
import { ClubListPlayer, PlayerbyClubMana } from 'src/app/models/club-list-player.model';
import { ClubPlayerInfoResponse, PlayerInfobyClubManaResponse } from 'src/app/models/player-info-response.model';
import { ClubService } from '../club.service';
import { DatePipe, formatDate } from '@angular/common';
import { PopUpConfirmDeletePlayerComponent } from '../pop-up-confirm-delete-player/pop-up-confirm-delete-player.component';
import { MatDialog } from '@angular/material/dialog';
import { AngularFireStorage } from '@angular/fire/storage';

@Component({
  selector: 'app-player-info',
  templateUrl: './player-info.component.html',
  styleUrls: ['./player-info.component.scss']
})
export class PlayerInfoComponent implements OnInit {
  playerInfo: PlayerbyClubMana = null;
  // playerClub: ClubListPlayerClub[];
  form: FormGroup;
  loading = false;
  submitted = false;
  playerId: number;
  clubId: number;

  defaultLogo: string = './../../../../assets/image/clubDefaultLogo.png';
  defaultAvatar: string = './../../../../assets/image/Default_pfp.svg.png';

  playerNum: number;
  Dob: Date;
  selectedImage: any = null;


  constructor(
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    public commonService: CommonService,
    private clubService: ClubService,
    public dialog: MatDialog,
    @Inject(AngularFireStorage) private storage: AngularFireStorage


  ) {
    this.route.queryParams.subscribe(params => {
      this.playerId = params['playerId'];
      this.clubId = params['clubId']
    });
  }

  ngOnInit(): void {
    this.initDataSource();


    this.form = this.formBuilder.group({
      clubId: this.clubId,
      playerId: this.playerId,
      name: [null, [Validators.required, this.noWhitespaceValidator]],
      nickName: [null,],
      avatar: [null,],
      number: [null, Validators.pattern('^[0-9]{1,2}$')],
      dob: [null, Validators.required],
      height: [null, [Validators.pattern('^[0-9]+[m][0-9]+$')]],
      weight: [null, [Validators.pattern('^[0-9,]+[k][g]$')]],
      address: [null,],
      phoneNumber: [null, [Validators.pattern('^[0-9]{1,15}$')]],
      email: [null, [Validators.email, Validators.pattern('^[a-zA-Z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$')]],
      socialCont: [null, [Validators.pattern('^[0-9]{1,15}$')]],
      clubName: [null,]

    })
  }


  get f() { return this.form.controls; }


  initDataSource() {
    this.clubService.getPlayerInfobyClubMana(this.playerId, this.clubId).pipe(
      map((res: PlayerInfobyClubManaResponse) =>
        //  {
        this.playerInfo = res.playerInfo,
        //   this.playerClub = res.playerInfo.playerClubs
        // }
      )
    ).subscribe(response => {
      if (response != null) this.bindValueIntoForm(response);
    }
    );
  }

  getControl(name: string) {
    return this.form.get(name) as FormControl;
  }

  bindValueIntoForm(res: PlayerbyClubMana) {

    this.form.controls['name'].patchValue(res.name);
    this.form.controls['nickName'].patchValue(res.nickName);

    this.form.controls['number'].patchValue(res.number);
    this.form.controls['dob'].patchValue(res.dob);
    this.form.controls['height'].patchValue(res.height);
    this.form.controls['weight'].patchValue(res.weight);

    this.form.controls['phoneNumber'].patchValue(res.phoneNumber);
    this.form.controls['address'].patchValue(res.address);
    this.form.controls['email'].patchValue(res.email);
    this.form.controls['socialCont'].patchValue(res.socialCont);

    this.form.controls['nickName'].disable();

    this.form.controls['clubName'].patchValue(res.clubName);
    this.form.controls['clubName'].disable();
    if (res.avatar != null) {
      this.defaultAvatar = res.avatar;
    }
  }

  // bindingDataIntoPlayer() {
  //   this.playerInfo = {
  //     clubId: this.clubId,
  //     playerId: this.playerId,
  //     name: this.getControl('name').value,
  //     nickName: this.getControl('nickName').value,
  //     number: this.getControl('number').value,
  //     dob: this.getControl('dob').value,
  //     height: this.getControl('height').value,
  //     weight: this.getControl('weight').value,
  //     address: this.getControl('address').value,
  //     phoneNumber: this.getControl('phoneNumber').value,
  //     email: this.getControl('email').value,
  //     socialCont: this.getControl('socialCont').value
  //   }
  // }

  showPreview(event: any) {
    if (event.target.files && event.target.files[0]) {
      let file = event.target.files[0];
      if (file.type == "image/png" || file.type == "image/jpeg" || file.size < 5000000) {
        console.log('Correct');
        const reader = new FileReader();
        reader.onload = (e: any) => this.defaultAvatar = e.target.result;
        reader.readAsDataURL(event.target.files[0]);
        this.selectedImage = event.target.files[0];
      } else {
        this.commonService.sendMessage('Invalid Image', 'fail');
      }
    } else {
      this.defaultAvatar = './../../../../assets/image/Default_pfp.svg.png';
      this.selectedImage = null;
    }
  }

  getCurrentDateTime(): string {
    return formatDate(new Date(), 'dd-MM-yyyy', 'en-US');
  }

  public onSubmit() {

    // this.bindingDataIntoPlayer();

    this.submitted = true;

    // stop here if form is invalid
    if (this.form.invalid) {
      return;
    }


    this.loading = true;


    if (this.selectedImage != null) {
      const nameImg = 'player/' + this.playerInfo.nickName +
        '/avatar/' + this.getCurrentDateTime() + this.selectedImage.name;
      const fileRef = this.storage.ref(nameImg);
      this.storage.upload(nameImg, this.selectedImage).snapshotChanges().pipe(
        finalize(() => {
          fileRef.getDownloadURL().subscribe((url) => {

            this.form.get('avatar').patchValue(url);

            this.clubService.editPlayer(this.form.value)
              .pipe(first())
              .subscribe({
                next: () => {
                  this.initDataSource();
                  this.commonService.sendMessage('Update player s info success!', 'success');
                  this.router.navigateByUrl('/manager/club-detail?clubId=' + this.clubId);  
                },
                error: error => {
                  this.loading = false;
                  this.commonService.sendMessage('Update fail!.', 'fail');
                }
              });

          });
        })
      ).subscribe();
    } else {
      this.clubService.editPlayer(this.form.value)
        .pipe(first())
        .subscribe({
          next: () => {
            this.initDataSource();
            this.commonService.sendMessage('Update player s info success!', 'success');
            // this.router.navigate(['/manager/club-detail?clubId=' + this.clubId]);  
            this.router.navigateByUrl('/manager/club-detail?clubId=' + this.clubId);
          },
          error: error => {
            this.loading = false;
            this.commonService.sendMessage('Update fail!.', 'fail');
          }
        });
    }
  }

  // openDeleteplayerConfirm(playerId: number, clubId:number): void {
  //   const dialogRef = this.dialog.open(PopUpConfirmDeletePlayerComponent, {
  //     width: '50%',
  //     data: { playerId: playerId , clubId: this.clubId}
  //   });
  //   dialogRef.afterClosed().subscribe(result => {
  //     console.log('The dialog was closed');


  //   });
  // }


  public noWhitespaceValidator(control: FormControl) {
    const isWhitespace = (control.value || '').trim().length === 0;
    const isValid = !isWhitespace;
    return isValid ? null : { 'whitespace': true };
  }

  backClicked() {

  }

}
