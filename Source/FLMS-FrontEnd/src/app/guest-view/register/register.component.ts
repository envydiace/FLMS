import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { first } from 'rxjs/operators';

import { AuthService } from '../../auth/auth.service';
import { RegisterService } from '../../guest-view/register/register.service';
import { LoginComponent } from '../login/login.component';

interface Role {
  value: string;
  viewValue: string;
}
@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent implements OnInit {
  form: FormGroup;
  loading = false;
  submitted = false;
  roles: string[] = ['CLUB_MANAGER', 'LEAGUE_MANAGER']
  selectedValue: string;

  constructor(
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private RegisterServer: RegisterService
  ) { 
    this.form = new FormGroup({
      email: new FormControl(),
      password: new FormControl(),
      confirmPassword: new FormControl(),
      fullName: new FormControl(),
      phone: new FormControl(),
      address: new FormControl(),
      role: new FormControl()
    })
  }

  ngOnInit(): void {
    this.form = this.formBuilder.group({
      email: ['', Validators.required],
      password: ['', Validators.required],
      confirmPassword: ['', Validators.required],
      fullName: ['', Validators.required],
      phone: ['', Validators.required],
      address: ['', Validators.required],
      role: ['', Validators.required]
    });
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
    this.RegisterServer.register(this.form.value)
      .pipe(first())
      .subscribe({
        next: () => {
          // get return url from query parameters or default to home page
          // const returnUrl = this.route.snapshot.queryParams['returnUrl'] || '/';
          // this.router.navigateByUrl(returnUrl);
          // this.router.navigate([../LoginComponent],)
        },
        error: error => {
          this.loading = false;
        }
      });
  }
}


