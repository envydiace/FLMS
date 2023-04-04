import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ForgotPassService } from '../forgot-pass.service';
import { CommonService } from 'src/app/common/common/common.service';
import { first } from 'rxjs/operators';

@Component({
  selector: 'app-forgot-pass-change',
  templateUrl: './forgot-pass-change.component.html',
  styleUrls: ['./forgot-pass-change.component.scss']
})
export class ForgotPassChangeComponent implements OnInit {


  form: FormGroup;
  loading = false;
  submitted = false;

  constructor(
    private formBuilder: FormBuilder,
    private router: Router,
    private route: ActivatedRoute,
    private forgotPassService: ForgotPassService,
    private commonService: CommonService
  ) { }

  ngOnInit(): void {
    this.form = this.formBuilder.group({
      email: ['', [Validators.required,Validators.email, Validators.pattern('^[a-zA-Z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$')]]
    });
  }
  get f() { return this.form.controls; }

  onSubmit() {
    this.submitted = true;

    // stop here if form is invalid
    if (this.form.invalid) {
      return;
    }

    let email = this.form.get('email').value
    this.loading = true;
    this.forgotPassService.getEmailForgotPassword(email).pipe(first())
      .subscribe({
        next: () => {
          this.commonService.sendMessage('An email with instructions on how to reset your password has been sent to your email address.', 'success');
        },
        error: error => {
          this.loading = false;
          this.commonService.sendMessage(error.error.message, 'fail');
        }
      }
      );
  }
}
