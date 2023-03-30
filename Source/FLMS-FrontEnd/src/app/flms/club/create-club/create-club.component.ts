import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ClubService } from '../club.service';
import { first } from 'rxjs/operators';
import { formatDate } from '@angular/common';
import { finalize } from "rxjs/operators";
import {AngularFireStorage} from '@angular/fire/storage';
import { CommonService } from 'src/app/common/common/common.service';

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
  selectedImage: any = null;

  constructor(
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private clubService: ClubService,
    public commonService: CommonService,
    @Inject(AngularFireStorage) private storage: AngularFireStorage
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
      clubName: [null],
      email: [null, Validators.required],
      phoneNumber: [null, Validators.required],
      socialCont: [null, Validators.required],
      logo: [null],
      kit: [null]
    });

  }
  get f() { return this.form.controls; }

  showPreview(event: any) {
    this.selectedImage = event.target.files[0];
  }

  onSubmit() {
    this.submitted = true;

    // stop here if form is invalid
    if (this.form.invalid) {
      return;
    }

    this.loading = true;

    // upload image to firebase
    const nameImg = this.getCurrentDateTime() + this.selectedImage.name;
    const fileRef = this.storage.ref(nameImg);
    this.storage.upload(nameImg, this.selectedImage).snapshotChanges().pipe(
      finalize(() => {
        fileRef.getDownloadURL().subscribe((url) => {

          this.form.get('logo').patchValue(url);

          this.clubService.addClub(this.form.value)
            .pipe(first()).subscribe({
              next: () => {
                this.commonService.sendMessage("Create Club success",'success');
                this.router.navigate(['/club-list'])
              },
              error: error => {
                this.loading = false;
                this.commonService.sendMessage(error.error.message,'fail');
              }
            });

        });
      })
    ).subscribe();




  }

  getCurrentDateTime(): string {
    return formatDate(new Date(), 'dd-MM-yyyy', 'en-US');
  }

  getErrorClubName() {
    return this.form.get('clubName').hasError('required') ? 'Field ClubName is required' : '';
  }

  getErrorEmail() {
    return this.form.get('email').hasError('required') ? 'Field Email is required' : '';
  }
  getErrorPhoneNumber() {
    return this.form.get('phoneNumber').hasError('required') ? 'Field phoneNumber is required' : '';
  }
  getErrorSocialCont() {
    return this.form.get('socialCont').hasError('required') ? 'Field socialCont is required' : '';
  }

}
