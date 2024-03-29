import { Component, ErrorHandler, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ProfileService } from '../profile.service';
import { first } from 'rxjs/operators';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { map } from 'rxjs/operators';
import { token } from 'src/app/models/token.model';
import { CommonService } from 'src/app/common/common/common.service';
import { ConfirmPasswordValidator } from './confirm-password.validator';


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
      newpassword: ['', [Validators.required, Validators.pattern('^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,32}$')]],
      cfpassword: ['', Validators.required]
    },
      {
        validator: ConfirmPasswordValidator("newpassword", "cfpassword")
      }
    );
  }
  get f() { return this.form.controls; }

  get newpass() { return this.form.get('newpassword'); }

  onSubmit() {
    this.submitted = true;

    // stop here if form is invalid
    if (this.form.invalid) {
      return;
    }

    let passValue = {
      oldPassword: this.form.get('oldpassword').value,
      newPassword: this.form.get('newpassword').value,
      rePassword: this.form.get('cfpassword').value,
    }
    this.profileService.changePassword(passValue).pipe(first())
      .subscribe({
        next: response => {
          this.router.navigate(['/manager/view-profile']);
          this.commonService.sendMessage(response.message, 'success');
        },
        error: error => {
          this.loading = false;
          this.commonService.sendMessage(error.error.message, 'fail');
        }
      });
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
