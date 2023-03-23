import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ProfileService } from '../profile.service';
import { first } from 'rxjs/operators';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { map } from 'rxjs/operators';
import { token } from 'src/app/models/token.model';
import { CommonService } from 'src/app/common/common/common.service';


export interface Tile {
  color: string;
  cols: number;
  rows: number;
  text: string;
}

@Component({
  selector: 'app-change-password',
  templateUrl: './change-password.component.html',
  styleUrls: ['./change-password.component.scss']
})
export class ChangePasswordComponent implements OnInit {

  form: FormGroup;
  loading = false;
  submitted = false;
  token: token;

  constructor(
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private profileService: ProfileService,
    private commonService: CommonService
  ) {
  }

  ngOnInit(): void {
    this.form = this.formBuilder.group({
      oldpassword: ['', Validators.required],
      newpassword: ['', Validators.required],
      cfpassword: ['', Validators.required]
    });
  }
  get f() { return this.form.controls; }

  onSubmit() {
    this.submitted = true;

    // stop here if form is invalid
    if (this.form.invalid) {
      return;
    }
    if (this.form.get('newpassword').value == this.form.get('cfpassword').value) {
      let passValue = {
        oldPassword: this.form.get('oldpassword').value,
        newPassword: this.form.get('newpassword').value,
        rePassword: this.form.get('cfpassword').value
      }
      this.profileService.changePassword(passValue).pipe(first())
        .subscribe({
          next: () => {
            this.router.navigate(['/manager/view-profile'])
            this.commonService.sendMessage('Change Password Success!', 'success')
          },
          error: error => {
            this.loading = false;
            this.commonService.sendMessage('Change Password Failed, please check again!', 'fail')
          }
        });
    } else {
      this.commonService.sendMessage('Password verification must match with new password!', 'fail')
    }

  }

  hide = true;

  getErrorPassword() {
    return this.form.get('oldpassword').hasError('required') ? 'Old Password is required' : '';
  }
  getErrorNewPassword() {
    return this.form.get('newpassword').hasError('required') ? 'New Password is required' : '';
  }
  getErrorRePassword() {
    return this.form.get('cfpassword').hasError('required') ? 'Re-Password is required and match with New Password' : '';
  }
}
