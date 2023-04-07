import { HttpHeaders } from '@angular/common/http';
import { Component, Inject, OnInit } from '@angular/core';
import { AngularFireStorage } from '@angular/fire/storage';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { ActivatedRoute, Router } from '@angular/router';
import { finalize, first, map } from 'rxjs/operators';
import { AuthService } from 'src/app/auth/auth.service';
import { CommonService } from 'src/app/common/common/common.service';

import { UpdateClubDetailResponse } from 'src/app/models/club-detail-response.model';
import { GetUpdateClubDetail } from 'src/app/models/club-detail.model';
import { token } from 'src/app/models/token.model';
import { ClubService } from '../club.service';
import { formatDate } from '@angular/common';

@Component({
  selector: 'app-pop-up-edit-club',
  templateUrl: './pop-up-edit-club.component.html',
  styleUrls: ['./pop-up-edit-club.component.scss']
})
export class PopUpEditClubComponent implements OnInit {
  clubDetail: GetUpdateClubDetail
  form: FormGroup;
  loading = false;
  submitted = false;
  defaultLogo: string = './../../../../assets/image/clubDefaultLogo.png';

  role: string;
  selectedImage: any = null;

  token: token;
  private headers: HttpHeaders;

  constructor(
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    public commonService: CommonService,
    public authSer: AuthService,
    public common: CommonService,
    public clubService: ClubService,
    public dialogRef: MatDialogRef<PopUpEditClubComponent>,
    @Inject(AngularFireStorage) private storage: AngularFireStorage,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      clubId: number;
    },
  ) {


    this.form = new FormGroup({
      clubName: new FormControl(),
      logo: new FormControl(),
      fanPage: new FormControl(),
      email: new FormControl(),
      phoneNumber: new FormControl(),
    })

    this.token = JSON.parse(localStorage.getItem('user'));
    this.headers = new HttpHeaders().set('Authorization', `Bearer ${this.token.accessToken}`);

  }

  ngOnInit(): void {
    this.initDataSource();

    this.form = this.formBuilder.group({
      clubId: this.data.clubId,
      clubName: [null, [Validators.required, Validators.pattern('^[a-zA-Z0-9 ]*$'), this.noWhitespaceValidator]],
      logo: [null,],
      fanPage: [null,],
      email: [null, [Validators.pattern('^[a-zA-Z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$'), this.noWhitespaceValidator]],
      phoneNumber: ['', Validators.pattern('^[0-9]{1,15}$')],

    })
  }

  get f() { return this.form.controls; }


  getCurrentDateTime(): string {
    return formatDate(new Date(), 'dd-MM-yyyy', 'en-US');
  }
  initDataSource() {

    this.clubService.getUpdateClubInfo(this.data.clubId).pipe(
      map((res: UpdateClubDetailResponse) => this.clubDetail = res.info)
    ).subscribe(response => {
      if (response != null) this.bindValueIntoForm(response);
    }
    );

  }

  bindValueIntoForm(res: GetUpdateClubDetail) {
    this.form.controls['clubName'].patchValue(res.clubName);
    this.form.controls['clubName'].disable();
    this.form.controls['fanPage'].patchValue(res.fanPage);
    this.form.controls['email'].patchValue(res.email);
    this.form.controls['phoneNumber'].patchValue(res.phoneNumber);


    if (res.logo != null) {
      this.defaultLogo = res.logo;
    }

  }

  showPreview(event: any) {
    if (event.target.files && event.target.files[0]) {
      let file = event.target.files[0];
      if (file.type == "image/png" || file.type == "image/jpeg" || file.size < 5000000) {
        console.log('Correct');
        const reader = new FileReader();
        reader.onload = (e: any) => this.defaultLogo = e.target.result;
        reader.readAsDataURL(event.target.files[0]);
        this.selectedImage = event.target.files[0];
      } else {
        this.commonService.sendMessage('Invalid Image', 'fail');
      }
    } else {
      this.defaultLogo = './../../../../assets/image/default-avatar-profile-icon.webp';
      this.selectedImage = null;
    }
  }

  public onSubmit() {
    this.submitted = true;

    // stop here if form is invalid
    if (this.form.invalid) {
      return;
    }
    this.loading = true;

    if (this.selectedImage != null) {
      const nameImg = 'club/' + this.data.clubId +
        '/logo/' + this.getCurrentDateTime() + this.selectedImage.name;
      const fileRef = this.storage.ref(nameImg);
      this.storage.upload(nameImg, this.selectedImage).snapshotChanges().pipe(
        finalize(() => {
          fileRef.getDownloadURL().subscribe((url) => {

            this.form.get('logo').patchValue(url);

            this.clubService.updateClub(this.form.value)
              .pipe(first())
              .subscribe({
                next: () => {
                  this.dialogRef.close();
                  // this.initDataSource();
                  this.common.sendMessage('Club Info Updated!', 'success')
                },
                error: error => {
                  this.loading = false;
                  this.common.sendMessage(error.error.message, 'fail')
                }
              });

          });
        })
      ).subscribe();

    } else {
      this.form.get('logo').patchValue(this.clubDetail.logo);

      this.clubService.updateClub(this.form.value)
        .pipe(first())
        .subscribe({
          next: () => {
            this.dialogRef.close();
            // this.initDataSource();
            this.common.sendMessage('Club Info Updated!', 'success')
          },
          error: error => {
            this.loading = false;
            this.common.sendMessage(error.error.message, 'fail')
          }
        });
    }


  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  public noWhitespaceValidator(control: FormControl) {
    const isWhitespace = (control.value || '').trim().length === 0;
    const isValid = !isWhitespace;
    return isValid ? null : { 'whitespace': true };
  }
}
