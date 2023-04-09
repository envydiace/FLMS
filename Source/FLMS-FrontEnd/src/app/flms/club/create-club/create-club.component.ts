import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ClubService } from '../club.service';
import { first } from 'rxjs/operators';
import { formatDate } from '@angular/common';
import { finalize } from "rxjs/operators";
import { AngularFireStorage } from '@angular/fire/storage';
import { CommonService } from 'src/app/common/common/common.service';
import { AddClub } from 'src/app/models/club-detail.model';

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
  imgSrc: string = './../../../../assets/image/clubDefaultLogo.png';
  selectedImage: any = null;

  clubInfo: AddClub;

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
      fanPage: new FormControl(),
      logo: new FormControl(),
      kit: new FormControl()
    })
  }

  ngOnInit(): void {
    this.createFrom();

  }

  createFrom() {
    this.form = this.formBuilder.group({
      'clubName': [null, [Validators.required, Validators.nullValidator, Validators.pattern('^(\s+\S+\s*)*(?!\s).*$'), this.noWhitespaceValidator]],
      'email': [null, [Validators.required, Validators.email, Validators.pattern('^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$')]],
      'phoneNumber': [null, [Validators.required, Validators.pattern('^[0-9]{1,15}$')]],
      'fanPage': [null, [Validators.required]],
      // 'email': [null, Validators.required,],
      // 'phoneNumber': [null, Validators.required],
      // 'socialCont': [null, Validators.required],
      'logo': [null],
      'kit': [null]
    });
  }
  getControl(name: string) {
    return this.form.get(name) as FormControl;
  }

  bindDataIntoClub() {
    this.clubInfo = {
      clubName: this.getControl('clubName').value.trim(),
      email: this.getControl('email').value,
      phoneNumber: this.getControl('phoneNumber').value,
      fanPage: this.getControl('fanPage').value,
      logo: this.getControl('logo').value,
      kit: null

    }
  }

  // get f() { return this.form.controls; }

  showPreview(event: any) {
    // this.selectedImage = event.target.files[0];
    if (event.target.files && event.target.files[0]) {
      let file = event.target.files[0];
      if (file.type == "image/png" || file.type == "image/jpeg" || file.size < 5000000) {
        console.log('Correct');
        const reader = new FileReader();
        reader.onload = (e: any) => this.imgSrc = e.target.result;
        reader.readAsDataURL(event.target.files[0]);
        this.selectedImage = event.target.files[0];
      } else {
        this.commonService.sendMessage('Invalid Image', 'fail');
      }
    } else {
      this.imgSrc = './../../../../assets/image/default-logo.png';
      this.selectedImage = null;
    }
  }

  onSubmit() {

    this.submitted = true;

    this.bindDataIntoClub();

    // stop here if form is invalid
    if (this.form.invalid) {
      return;
    }

    this.loading = true;
    if (this.selectedImage != null) {
    // upload image to firebase
    const nameImg = 'club/' + this.clubInfo.clubName +
      '/logo/' + this.getCurrentDateTime() + this.selectedImage.name;
    const fileRef = this.storage.ref(nameImg)

  
      this.storage.upload(nameImg, this.selectedImage).snapshotChanges().pipe(
        finalize(() => {
          fileRef.getDownloadURL().subscribe((url) => {

            this.clubInfo.logo = url;

            this.clubService.addClub(this.clubInfo)
              .pipe(first()).subscribe({
                next: response => {
                  this.commonService.sendMessage(response.message, 'success');
                  this.router.navigate(['manager/my-clubs']);
                },
                error: error => {
                  this.loading = false;
                  this.commonService.sendMessage(error.error.message, 'fail');
                }
              });

          });
        })
      ).subscribe();
    } else {
  

      this.clubService.addClub(this.clubInfo)
        .pipe(first()).subscribe({
          next: response => {
            this.commonService.sendMessage(response.message, 'success');
            this.router.navigate(['manager/my-clubs']);
          },
          error: error => {
            this.loading = false;
            this.commonService.sendMessage(error.error.message, 'fail');
          }
        });
    }
  }

  public noWhitespaceValidator(control: FormControl) {
    const isWhitespace = (control.value || '').trim().length === 0;
    const isValid = !isWhitespace;
    return isValid ? null : { 'whitespace': true };
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
    return this.form.get('fanPage').hasError('required') ? 'Field fanPage is required' : '';
  }

  backButton() {

    return this.router.navigate(['manager/my-clubs'])
  }
}
