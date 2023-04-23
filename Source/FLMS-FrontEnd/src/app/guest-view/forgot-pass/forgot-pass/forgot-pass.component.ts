import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { first } from 'rxjs/operators';
import { CommonService } from 'src/app/common/common/common.service';
import { ForgotPassService } from './../forgot-pass.service';
import { Router } from '@angular/router';
@Component({
  selector: 'app-forgot-pass',
  templateUrl: './forgot-pass.component.html',
  styleUrls: ['./forgot-pass.component.scss']
})
export class ForgotPassComponent implements OnInit {
  form: FormGroup;
  loading = false;
  submitted = false;
  hide = true;

  constructor(
    private formBuilder: FormBuilder,
    private router: Router,
    private forgotPassService: ForgotPassService,
    private commonService: CommonService
  ) { }

  ngOnInit(): void {
    this.form = this.formBuilder.group({
      newPassword: ['', [Validators.required,Validators.pattern('^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,32}$')]],
      rePassword: ['', Validators.required]
    });
  }
  get f() { return this.form.controls; }

  onSubmit() {
    let url = this.router.url;
    this.submitted = true;

    // stop here if form is invalid
    if (this.form.invalid) {
      return;
    }

    let changepass = {
      newPassword: this.form.get('newPassword').value,
      rePassword: this.form.get('rePassword').value,
      token: decodeURIComponent(url.substring(13,)),
    }

    this.loading = true;
    this.forgotPassService.ChangePassword(changepass).pipe(first())
      .subscribe({
        next: response => {
          this.router.navigate(['/login']);
          this.commonService.sendMessage(response.message, 'success');
        },
        error: error => {
          this.loading = false;
          this.commonService.sendMessage(error.error.message, 'fail');
        }
      }
      );
  }


}
