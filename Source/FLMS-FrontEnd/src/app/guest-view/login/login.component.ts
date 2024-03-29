import { Component, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { first } from 'rxjs/operators';
import { CommonService } from 'src/app/common/common/common.service';

import { environment } from '../../../environments/environment';
import { AuthService } from '../../auth/auth.service';
import { MatTabGroup } from '@angular/material/tabs';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {
  form: FormGroup;
  loading = false;
  submitted = false;
  @ViewChild('tabGroup') tabGroup: MatTabGroup;

  constructor(
    private commonService: CommonService,
    private formBuilder: FormBuilder,
    private authService: AuthService
  ) { }

  ngOnInit(): void {
    localStorage.removeItem('user');
    this.form = this.formBuilder.group({
      username: ['', Validators.required],
      password: ['', Validators.required]
    });
  }

  activeTab(index: number) {
    this.tabGroup.selectedIndex = index;
  }

  // convenience getter for easy access to form fields
  get f() { return this.form.controls; }

  onSubmit() {
    this.submitted = true;

    // stop here if form is invalid
    if (this.form.invalid) {
      return;
    }

    this.loading = true;
    this.authService.login(this.f.username.value, this.f.password.value)
      .pipe(first())
      .subscribe({
        next: () => {
          // get return url from query parameters or default to home page
          // const returnUrl = this.route.snapshot.queryParams['returnUrl'] || '/';
          window.location.href = environment.localUrl + '/manager';
          this.commonService.sendMessage('Login Success!', 'success');
        },
        error: error => {
          this.commonService.sendMessage(error.error.message, 'fail');
          this.loading = false;
        }
      });
  }
}
