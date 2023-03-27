import { Component, OnInit } from '@angular/core';
import { ProfileService } from '../profile.service';
import { UserProfileResponse } from 'src/app/models/user-profile-response.model';
import { UserProfile } from 'src/app/models/user-profile.model';
import { map } from 'rxjs/operators';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { first } from 'rxjs/operators';
import { HttpHeaders } from '@angular/common/http';
import { token } from 'src/app/models/token.model';
import { AuthService } from 'src/app/auth/auth.service';

@Component({
  selector: 'app-view-profile',
  templateUrl: './view-profile.component.html',
  styleUrls: ['./view-profile.component.scss']
})
export class ViewProfileComponent implements OnInit {
  userProfile: UserProfile ;
  form: FormGroup;
  loading = false;
  submitted = false;
  defaultLogo: string = './../../../../assets/image/default-avatar-profile-icon.webp';

  role: string;

  token: token;
  private headers: HttpHeaders;
  constructor(
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    public authSer: AuthService,
    private profileService: ProfileService

  ) {
    this.form = new FormGroup({
      fullName: new FormControl(),
      phone: new FormControl(),
      address: new FormControl(),
      avatar: new FormControl()
    })

    this.token = JSON.parse(localStorage.getItem('user'));
    this.headers = new HttpHeaders().set('Authorization', `Bearer ${this.token.accessToken}`);
  }

  ngOnInit(): void {
    this.initDataSource();

    console.log("123" +this.userProfile);
    this.form = this.formBuilder.group({
      fullName: ['', Validators.required],
      phone: ['', Validators.required],
      address: ['', Validators.required],
      email: ['', Validators.required],
      avatar:['', ],
    })
    
    this.role = this.authSer.getUserRole();
  }

  get f() { return this.form.controls; }


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
    this.form.controls['avatar'].patchValue(res.avatar);
  }

  public onSubmit() {
    this.submitted = true;

    // stop here if form is invalid
    if (this.form.invalid) {
      return;
    }

    this.loading = true;
    this.profileService.editProfile(this.form.value)
      .pipe(first())
      .subscribe({
        next: () => {
          this.initDataSource();
        },
        error: error => {
          this.loading = false;
        }
      });

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
