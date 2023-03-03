import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ClubService } from '../club.service';
import { first } from 'rxjs/operators';


interface Role {
  value: string;
  viewValue: string;
}

@Component({
  selector: 'app-create-club',
  templateUrl: './create-club.component.html',
  styleUrls: ['./create-club.component.scss']
})
export class CreateClubComponent implements OnInit {
  form: FormGroup;
  loading = false;
  submitted = false;
  roles: string[] = ['Club Manager', 'League Manager']


  constructor(
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private clubService: ClubService
  ) {
    this.form = new FormGroup({
      clubName: new FormControl(),
      email: new FormControl(),
      phoneNumber: new FormControl(),
      socialCont: new FormControl(),
      logo: new FormControl(),
      kit: new FormControl()
    })
  }

  ngOnInit(): void {
    this.form = this.formBuilder.group({
      clubName: ['', Validators.required],
      email: ['', Validators.required],
      phoneNumber: ['', Validators.required],
      socialCont: ['', Validators.required],
      logo: ['', Validators.required],
      kit: ['', Validators.required]
    });

  }
  get f() { return this.form.controls; }

  onSubmit() {
    this.submitted = true;

    // stop here if form is invalid
    // if (this.form.invalid) {
    //   return;
    // }

    this.loading = true;

    this.clubService.addClub(this.form.value)
      .pipe(first()).subscribe({
        next: () => {
          this.router.navigate(['/club-list'])
        },
        error: error => {
          this.loading = false;
        }
      });
  }
  getErrorClubName(){
    return this.form.get('clubName').hasError('required') ? 'Field ClubName is required': '';
  }

  getErrorEmail(){
    return this.form.get('email').hasError('required') ? 'Field Email is required': '';
  }
  getErrorPhoneNumber(){
    return this.form.get('phoneNumber').hasError('required') ? 'Field phoneNumber is required': '';
  }
  getErrorSocialCont(){
    return this.form.get('socialCont').hasError('required') ? 'Field socialCont is required': '';
  }

}
