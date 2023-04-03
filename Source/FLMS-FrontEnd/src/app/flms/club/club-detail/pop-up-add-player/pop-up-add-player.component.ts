import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { FormBuilder, FormGroup, FormControl, Validators } from '@angular/forms';
import { ClubService } from '../../club.service';
import { debounceTime, delay, distinctUntilChanged, finalize, first } from 'rxjs/operators';
import { Player, PLayerInfo } from 'src/app/models/player.model';
import { CommonService } from 'src/app/common/common/common.service';
import { AngularFireStorage } from '@angular/fire/storage';
import { formatDate } from '@angular/common';
import { MAT_DATE_LOCALE } from '@angular/material/core';

@Component({
  selector: 'app-pop-up-add-player',
  templateUrl: './pop-up-add-player.component.html',
  styleUrls: ['./pop-up-add-player.component.scss']
})
export class PopUpAddPlayerComponent implements OnInit {
  addPlayerFormGroup: FormGroup;
  loading = false;
  player: Player;

  imgSrc: string = './../../../../assets/image/default-avatar-profile-icon.webp';
  selectedImage: any;

  constructor(
    private formBuilder: FormBuilder,
    private clubService: ClubService,
    public dialogRef: MatDialogRef<PopUpAddPlayerComponent>,
    public commonService: CommonService,
    @Inject(AngularFireStorage) private storage: AngularFireStorage,

    @Inject(MAT_DIALOG_DATA)
    public data: {
      clubId: number;
      clubName: string;
    }
  ) { }

  ngOnInit(): void {
    this.createForm();
  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  createForm() {
    this.addPlayerFormGroup = this.formBuilder.group({
      'playerName': [null, [Validators.required, Validators.pattern('^[a-zA-Z0-9 ]*$'), this.noWhitespaceValidator]],
      'number': [null, [Validators.required]],
      'playerHeight': [null, [Validators.required, Validators.pattern('^[0-9]+[m][0-9]+$')]],
      'address': [null, [Validators.required]],
      'email': [null, [Validators.required, Validators.email, Validators.pattern('^[a-zA-Z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$')]],
      'nickname': [null, [Validators.required, Validators.minLength(3)]],
      'dob': [null, [Validators.required]],
      'weight': [null, [Validators.required, Validators.pattern('^[0-9,]+[k][g]$')]],
      'phoneNumber': [null, [Validators.required, Validators.pattern('^[0-9]{1,15}$')]],
      'socialCont': [null, [Validators.required]],
      'clubName': [null,],
      'avatar': [null,]
    });
  }
  showPreview(event: any) {
    if (event.target.files && event.target.files[0]) {
      let file = event.target.files[0];
      if (file.type == "image/png" || file.type == "image/jpeg" || file.size < 5000000) {
        console.log('Correct');
        const reader = new FileReader();
        reader.onload = (e: any) => this.imgSrc = e.target.result;
        reader.readAsDataURL(event.target.files[0]);
        this.selectedImage = event.target.files[0];
      } else {
        this.commonService.sendMessage('Invalid Image', 'fail');
      }
    } else {
      this.imgSrc = './../../../../assets/image/default-avatar-profile-icon.webp';
      this.selectedImage = null;
    }
  }

  getControl(name: string) {
    return this.addPlayerFormGroup.get(name) as FormControl;
  }

  bindDataIntoPlayer() {
    this.player = {
      playerId: null,
      name: this.getControl('playerName').value,
      nickName: this.getControl('nickname').value,
      dob: this.commonService.addHoursToDate(this.getControl('dob').value),
      height: this.getControl('playerHeight').value,
      weight: this.getControl('weight').value,
      address: this.getControl('address').value,
      phoneNumber: this.getControl('phoneNumber').value,
      email: this.getControl('email').value,
      socialCont: this.getControl('socialCont').value,
      clubId: this.data.clubId,
      number: this.getControl('number').value,
      avatar: this.getControl('avatar').value

    }
  }

  getCurrentDateTime(): string {
    return formatDate(new Date(), 'dd-MM-yyyy', 'en-US');
  }

  onSubmit() {
    this.bindDataIntoPlayer();

    // stop here if form is invalid
    if (this.addPlayerFormGroup.invalid) {
      return;
    }

    this.loading = true;

    const nameImg = 'club/' + this.data.clubName
      + '/player/' + this.player.name
      + '/playerNickName/' + this.player.nickName
      + '/playerAva/' + this.getCurrentDateTime();
    const fileRef = this.storage.ref(nameImg);

    if (this.selectedImage != null) {
      this.storage.upload(nameImg, this.selectedImage).snapshotChanges().pipe(
        finalize(() => {
          fileRef.getDownloadURL().subscribe((url) => {

            this.player.avatar = url;

            this.clubService.addPlayer(this.player)
              .pipe(first())
              .subscribe({
                next: () => {
                  this.commonService.sendMessage("Add player success", 'success');

                },
                error: error => {
                  this.loading = false;
                  this.commonService.sendMessage(error.error.message, 'fail');
                }
              });

          });
        })
      ).subscribe(() => {
        this.dialogRef.close();
      });
    } else {
      this.clubService.addPlayer(this.player)
        .pipe(first())
        .subscribe({
          next: () => {
            this.commonService.sendMessage("Add player success", 'success');

          },
          error: error => {
            this.loading = false;
            this.commonService.sendMessage(error.error.message, 'fail');
          }
        });
    }
  }

  // findByNickName() {
  //   this.getControl('nickname').valueChanges
  //   .pipe(debounceTime(500), distinctUntilChanged())
  //   .subscribe(value => this.getPlayerByNickName());
  // }

  getPlayerByNickName() {
    this.clubService.getPlayerByNickName(this.getControl('nickname').value.trim())
      .subscribe({
        next: res => {
          if (res != null && res != undefined && res.playerInfo != undefined) {
            this.bindPLayerFromNickName(res);
            this.disableFormAfterGetFromNickName();
            this.commonService.sendMessage(res.playerInfo.name, 'success');
          }
        },
        error: error => {
          this.loading = false;
        }
      })
  }

  bindPLayerFromNickName(player: PLayerInfo) {
    this.addPlayerFormGroup.patchValue({
      playerName: player.playerInfo.name,
      number: null,
      playerHeight: player.playerInfo.height,
      address: player.playerInfo.address,
      email: player.playerInfo.email,
      nickname: player.playerInfo.nickName,
      dob: player.playerInfo.dob,
      weight: player.playerInfo.weight,
      phoneNumber: player.playerInfo.phoneNumber,
      socialCont: player.playerInfo.socialCont,
      clubName: this.data.clubName,
      avatar: player.playerInfo.avatar
    });
    if (player.playerInfo.avatar != null && player.playerInfo.avatar != undefined)
      this.imgSrc = player.playerInfo.avatar;
  }

  disableFormAfterGetFromNickName() {
    this.getControl('playerName').disable();
    this.getControl('dob').disable();
    this.getControl('playerHeight').disable();
    this.getControl('weight').disable();
    this.getControl('address').disable();
    this.getControl('phoneNumber').disable();
    this.getControl('email').disable();
    this.getControl('socialCont').disable();
  }

  enableFormAfterGetFromNickName() {
    this.getControl('playerName').enable();
    this.getControl('dob').enable();
    this.getControl('playerHeight').enable();
    this.getControl('weight').enable();
    this.getControl('address').enable();
    this.getControl('phoneNumber').enable();
    this.getControl('email').enable();
    this.getControl('socialCont').enable();
  }

  public noWhitespaceValidator(control: FormControl) {
    const isWhitespace = (control.value || '').trim().length === 0;
    const isValid = !isWhitespace;
    return isValid ? null : { 'whitespace': true };
  }
}
