import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonService } from 'src/app/common/common/common.service';
import { PlayerbyClubMana } from 'src/app/models/club-list-player.model';
import { ClubService } from '../club.service';
import { MAT_DIALOG_DATA, MatDialog, MatDialogRef } from '@angular/material/dialog';
import { AngularFireStorage } from '@angular/fire/storage';
import { finalize, first, map } from 'rxjs/operators';
import { formatDate } from '@angular/common';
import { PlayerInfobyClubManaResponse } from 'src/app/models/player-info-response.model';

@Component({
  selector: 'app-pop-up-player-info',
  templateUrl: './pop-up-player-info.component.html',
  styleUrls: ['./pop-up-player-info.component.scss']
})
export class PopUpPlayerInfoComponent implements OnInit {
  playerInfo: PlayerbyClubMana = null;
  // playerClub: ClubListPlayerClub[];
  form: FormGroup;
  loading = false;
  submitted = false;
  playerId: number;
 

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
    public dialogRef: MatDialogRef<PopUpPlayerInfoComponent>,
    @Inject(AngularFireStorage) private storage: AngularFireStorage,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      playerId: number;
      clubId: number;
    },
  ) {

  }

  ngOnInit(): void {
    this.initDataSource();


    this.form = this.formBuilder.group({
      clubId: this.data.clubId,
      playerId: this.data.playerId,
      name: [null, [Validators.required, this.noWhitespaceValidator, Validators.maxLength(200)]],
      nickName: [null,],
      avatar: [null,],
      number: [null, [Validators.required, Validators.pattern('^[0-9]{1,2}$')]],
      dob: [null, Validators.required],
      height: [null, [Validators.pattern('^[0-9]+[m][0-9]+$')]],
      weight: [null, [Validators.pattern('^[0-9,]+[k][g]$')]],
      address: [null, Validators.maxLength(255)],
      phoneNumber: [null, [Validators.pattern('^[0-9]{1,15}$')]],
      email: [null, [Validators.email, Validators.pattern('^[a-zA-Z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$')]],
      socialCont: [null, [Validators.pattern('^[0-9]{1,15}$')]],
      clubName: [null,]

    })
  }

  get f() { return this.form.controls; }


  initDataSource() {
    this.clubService.getPlayerInfobyClubMana(this.data.playerId, this.data.clubId).pipe(
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
  showPreview(event: any) {
    if (event.target.files && event.target.files[0]) {
      let file = event.target.files[0];
      if (file.type == "image/png" || file.type == "image/jpeg" && file.size < 5000000) {
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
                next: response => {
                  this.loading = false;
                  this.initDataSource();
                  this.commonService.sendMessage(response.message, 'success');
                  this.dialogRef.close();
                },
                error: error => {
                  this.loading = false;
                  this.commonService.sendMessage(error.error.message, 'fail');
                }
              });

          });
        })
      ).subscribe();
    } else {
      this.clubService.editPlayer(this.form.value)
        .pipe(first())
        .subscribe({
          next: response => {
            this.loading = false;
            this.initDataSource();
            this.commonService.sendMessage(response.message, 'success');
            // this.router.navigate(['/manager/club-detail?clubId=' + this.clubId]);  
            this.dialogRef.close();
          },
          error: error => {
            this.loading = false;
            this.commonService.sendMessage(error.error.message, 'fail');
          }
        });
    }
  }
  public noWhitespaceValidator(control: FormControl) {
    const isWhitespace = (control.value || '').trim().length === 0;
    const isValid = !isWhitespace;
    return isValid ? null : { 'whitespace': true };
  }


}
