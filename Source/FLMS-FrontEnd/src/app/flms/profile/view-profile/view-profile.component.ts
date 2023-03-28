import { Component, Inject, OnInit } from '@angular/core';
import { ProfileService } from '../profile.service';
import { UserProfileResponse } from 'src/app/models/user-profile-response.model';
import { UserProfile } from 'src/app/models/user-profile.model';
import { finalize, map } from 'rxjs/operators';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { first } from 'rxjs/operators';
import { HttpHeaders } from '@angular/common/http';
import { token } from 'src/app/models/token.model';
import { AuthService } from 'src/app/auth/auth.service';
import { CommonService } from 'src/app/common/common/common.service';
import { AngularFireStorage } from '@angular/fire/storage';
import { formatDate } from '@angular/common';

@Component({
  selector: 'app-view-profile',
  templateUrl: './view-profile.component.html',
  styleUrls: ['./view-profile.component.scss']
})
export class ViewProfileComponent implements OnInit {
  userProfile: UserProfile;
  form: FormGroup;
  loading = false;
  submitted = false;
  imgSrc: string = './../../../../assets/image/default-avatar-profile-icon.webp';

  role: string;
  selectedImage: any = null;

  token: token;
  private headers: HttpHeaders;
  constructor(
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    public authSer: AuthService,
    public common: CommonService,
    private profileService: ProfileService,
    @Inject(AngularFireStorage) private storage: AngularFireStorage


  ) {
    this.form = new FormGroup({
      fullName: new FormControl(),
      phone: new FormControl(),
      address: new FormControl(),
      avatar: new FormControl(),
      role: new FormControl(),
      gmail: new FormControl(),
    })

    this.token = JSON.parse(localStorage.getItem('user'));
    this.headers = new HttpHeaders().set('Authorization', `Bearer ${this.token.accessToken}`);
  }

  ngOnInit(): void {
    this.initDataSource();

    this.form = this.formBuilder.group({
      fullName: ['', Validators.required],
      phone: ['', Validators.required],
      address: ['', Validators.required],
      email: ['', Validators.required],
      avatar: [null,],
      role: [null]
    })

    this.role = this.authSer.getUserRole();
  }

  get f() { return this.form.controls; }


  getCurrentDateTime(): string {
    return formatDate(new Date(), 'dd-MM-yyyy', 'en-US');
  }

  initDataSource() {
    this.profileService.getuserprofile().pipe(
      map((res: UserProfileResponse) => this.userProfile = res.userProfile)
    ).subscribe(response => {
      if (response != null) this.bindValueIntoForm(response);
    }
    );
  }

  bindValueIntoForm(res: UserProfile) {
    this.form.controls['fullName'].patchValue(res.fullName);
    this.form.controls['phone'].patchValue(res.phone);
    this.form.controls['address'].patchValue(res.address);
    this.form.controls['email'].patchValue(res.email);
    this.form.controls['email'].disable();
    this.imgSrc = res.avatar;
    this.form.controls['role'].patchValue(res.role);
    this.form.controls['role'].disable();

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

  public onSubmit() {
    this.submitted = true;

    // stop here if form is invalid
    if (this.form.invalid) {
      return;
    }

    this.loading = true;

    if (this.selectedImage != null ) {
      const nameImg = 'profile/' + this.userProfile.fullName + '/avatar/' + this.getCurrentDateTime() + this.selectedImage.name;
      const fileRef = this.storage.ref(nameImg);
      this.storage.upload(nameImg, this.selectedImage).snapshotChanges().pipe(
        finalize(() => {
          fileRef.getDownloadURL().subscribe((url) => {

            this.form.get('avatar').patchValue(url);

            this.profileService.editProfile(this.form.value)
              .pipe(first())
              .subscribe({
                next: () => {
                  this.initDataSource();
                  this.common.sendMessage('Info Updated!', 'success')
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

      this.profileService.editProfile(this.form.value)
        .pipe(first())
        .subscribe({
          next: () => {
            this.initDataSource();
            this.common.sendMessage('Info Updated!', 'success')
          },
          error: error => {
            this.loading = false;
            this.common.sendMessage(error.error.message, 'fail')
          }
        });
    }






  }

  getErrorName() {
    return this.form.get('fullName').hasError('required') ? 'Field Name is required' : '';
  }
  getErrorPhone() {
    return this.form.get('phone').hasError('required') ? 'Field Phone is required' : '';
  }
  getErrorAddress() {
    return this.form.get('address').hasError('required') ? 'Field Address is required' : '';
  }

}
