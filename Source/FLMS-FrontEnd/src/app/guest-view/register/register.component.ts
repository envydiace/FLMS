import { Component, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { first } from 'rxjs/operators';
import { CommonService } from 'src/app/common/common/common.service';
import { environment } from '../../../environments/environment';
import { AuthService } from '../../auth/auth.service';
import { RegisterService } from '../../guest-view/register/register.service';
import { LoginComponent } from '../login/login.component';
import { MatTabGroup } from '@angular/material/tabs';

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
  roles: string[] = ['Club Manager', 'League Manager']
  selectedValue: string;

  constructor(
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private RegisterService: RegisterService,
    private commonService: CommonService,
    public Logincomponent: LoginComponent
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
      email: ['', [Validators.required, Validators.email, Validators.pattern('^[a-zA-Z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$')]],
      password: ['', [Validators.required, Validators.pattern('^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,32}$')]],
      confirmPassword: ['', Validators.required],
      fullName: ['', [Validators.required, this.noWhitespaceValidator, Validators.maxLength(50)]],
      phone: ['', [Validators.required,Validators.pattern('^[0-9]{1,15}$')]],
      address: ['',[Validators.required,Validators.maxLength(255)]],
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
    this.RegisterService.register(this.form.value)
      .pipe(first())
      .subscribe({
        next: response => {
          this.router.navigate(['/login']).then(()=>{
            this.commonService.sendMessage(response.message, 'success');
            this.Logincomponent.activeTab(0);
            this.ClearFromAfterRegister();
          });
          this.commonService.sendMessage(response.message, 'success');
        },
        error: error => {
          this.loading = false;
          this.commonService.sendMessage(error.error.message, 'fail');
        }
      });
  }

  ClearFromAfterRegister(){
    this.form.patchValue({
      email: null,
      password: null,
      confirmPassword: null,
      fullName: null,
      phone: null,
      address: null,
      role: null
    });
  }

  hide = true;

  public noWhitespaceValidator(control: FormControl) {
    const isWhitespace = (control.value || '').trim().length === 0;
    const isValid = !isWhitespace;
    return isValid ? null : { 'whitespace': true };
  }
}

