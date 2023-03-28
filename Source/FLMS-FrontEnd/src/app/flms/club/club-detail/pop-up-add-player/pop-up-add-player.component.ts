import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { FormBuilder, FormGroup, FormControl, Validators } from '@angular/forms';
import { ClubService } from '../../club.service';
import { finalize, first } from 'rxjs/operators';
import { Player } from 'src/app/models/player.model';
import { CommonService } from 'src/app/common/common/common.service';
import { AngularFireStorage } from '@angular/fire/storage';
import { formatDate } from '@angular/common';

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
      'playerName': [null, [Validators.required]],
      'number': [null, [Validators.required]],
      'playerHeight': [null, [Validators.required]],
      'address': [null, [Validators.required]],
      'email': [null, [Validators.required]],
      'nickname': [null, [Validators.required]],
      'dob': [null, [Validators.required]],
      'weight': [null, [Validators.required]],
      'phoneNumber': [null, [Validators.required]],
      'socialCont': [null, [Validators.required]],
      'clubName': [null,],
      'avatar': [null, ]
    });
  }
  showPreview(event: any) {
    if (event.target.files && event.target.files[0]) {
      const reader = new FileReader();
      reader.onload = (e: any) => this.imgSrc = e.target.result;
      reader.readAsDataURL(event.target.files[0]);
      this.selectedImage = event.target.files[0];
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
      dob: this.getControl('dob').value,
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
    +'/playerAva/' + this.getCurrentDateTime() + this.selectedImage.name;
    const fileRef = this.storage.ref(nameImg);

    this.storage.upload(nameImg, this.selectedImage).snapshotChanges().pipe(
      finalize(() => {
        fileRef.getDownloadURL().subscribe((url) => {

          this.player.avatar = url;

          this.clubService.addPlayer(this.player)
          .pipe(first())
          .subscribe({
            next: () => {
              this.dialogRef.close();
              this.commonService.sendMessage("Add player success",'sucess');
    
            },
            error: error => {
              this.loading = false;
              this.commonService.sendMessage(error.error.message,'fail');
            }
          });

        });
      })
    ).subscribe();

  }
}
