import { HttpHeaders } from '@angular/common/http';
import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService } from 'src/app/auth/auth.service';
import { CommonService } from 'src/app/common/common/common.service';
import { GetUpdateLeagueDetail } from 'src/app/models/league-detail.model';
import { token } from 'src/app/models/token.model';
import { LeagueService } from '../league.service';
import { MAT_DIALOG_DATA, MatDialog, MatDialogRef } from '@angular/material/dialog';
import { AngularFireStorage } from '@angular/fire/storage';
import { finalize, first, map } from 'rxjs/operators';
import { UpdateLeagueDetailResponse } from 'src/app/models/league-detail-response.model';
import { formatDate } from '@angular/common';
import { PopUpConfirmEditLeagueComponent } from '../league-detail/pop-up-confirm-edit-league/pop-up-confirm-edit-league.component';

@Component({
  selector: 'app-pop-up-edit-league',
  templateUrl: './pop-up-edit-league.component.html',
  styleUrls: ['./pop-up-edit-league.component.scss']
})
export class PopUpEditLeagueComponent implements OnInit {
  leagueDetail: GetUpdateLeagueDetail;
  form: FormGroup;
  loading = false;
  conStatus = false;
  submitted = false;
  defaultLogo: string = './../../../../assets/image/default-logo.png';
  leagueInfo: GetUpdateLeagueDetail;

  selectedImage: any = null;

  token: token;
  private headers: HttpHeaders;


  constructor(
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    public common: CommonService,
    public dialog: MatDialog,
    public leagueService: LeagueService,
    public dialogRef: MatDialogRef<PopUpEditLeagueComponent>,
    @Inject(AngularFireStorage) private storage: AngularFireStorage,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      leagueId: number;
    },

  ) {

    this.form = new FormGroup({
      leagueId: new FormControl(),
      leagueName: new FormControl(),
      logo: new FormControl(),
      location: new FormControl(),
      fanpage: new FormControl(),
    })

    this.token = JSON.parse(localStorage.getItem('user'));
    this.headers = new HttpHeaders().set('Authorization', `Bearer ${this.token.accessToken}`);

  }

  ngOnInit(): void {
    this.initDataSource();

    this.form = this.formBuilder.group({
      leagueId: this.data.leagueId,
      leagueName: [null, [Validators.required, this.noWhitespaceValidator]],
      logo: [null,],
      fanpage: [null,],
      location: [null, [this.noWhitespaceValidator, Validators.maxLength(255)]],
      status: [null, ]

    });

    this.conStatus ;


  }

  get f() { return this.form.controls; }


  initDataSource() {

    this.leagueService.getUpdateLeagueInfo(this.data.leagueId).pipe(
      map((res: UpdateLeagueDetailResponse) => this.leagueDetail = res.info)
    ).subscribe(response => {
      if (response != null) this.bindValueIntoForm(response);
    }
    );

  }


  bindValueIntoForm(res: GetUpdateLeagueDetail) {
    res.leagueId = this.data.leagueId;
    this.form.controls['leagueName'].patchValue(res.leagueName);
    this.form.controls['leagueName'].disable();

    this.form.controls['location'].patchValue(res.location);
    this.form.controls['fanpage'].patchValue(res.fanpage);
    this.form.controls['status'].patchValue(res.status)
    if (res.logo != null) {
      this.defaultLogo = res.logo;
      this.form.controls['logo'].patchValue(res.logo);
    }

  }

  showPreview(event: any) {
    if (event.target.files && event.target.files[0]) {
      let file = event.target.files[0];
      if (file.type == "image/png" || file.type == "image/jpeg" && file.size < 5000000) {
        console.log('Correct');
        const reader = new FileReader();
        reader.onload = (e: any) => this.defaultLogo = e.target.result;
        reader.readAsDataURL(event.target.files[0]);
        this.selectedImage = event.target.files[0];
      } else {
        this.common.sendMessage('Invalid Image', 'fail');
      }
    } else {
      this.defaultLogo = './../../../../assets/image/default-logo.png';
      this.selectedImage = null;
    }
  }

  getCurrentDateTime(): string {
    return formatDate(new Date(), 'dd-MM-yyyy', 'en-US');
  }

  bindDataIntoLeague() {
    this.leagueInfo = {
      leagueId: this.leagueDetail.leagueId,
      leagueName: this.leagueDetail.leagueName,
      location: this.form.get('location').value,
      fanpage: this.form.get('fanpage').value,
      status: this.form.get('status').value,
      logo: this.form.get('logo').value
    }
  }

  openConfirmEditLeague( conStatus: boolean): void {
    const dialogRef = this.dialog.open(PopUpConfirmEditLeagueComponent, {
      width: '60%',
      data: { conStatus: conStatus },
      disableClose: true
    });
    dialogRef.afterClosed().subscribe(result => {
      if(conStatus = false){
        console.log('The dialog was closed');
      }else{
        this.initDataSource();
        this.onSubmit();
        console.log('The dialog was closed');
      }
    });
  }


  public onSubmit() {
    this.submitted = true;
    this.bindDataIntoLeague();

    // stop here if form is invalid
    if (this.form.invalid) {
      return;
    }
    this.loading = true;


    if (this.selectedImage != null) {
      const nameImg = 'league/' + this.data.leagueId +
        '/logo/' + this.getCurrentDateTime() + this.selectedImage.name;
      const fileRef = this.storage.ref(nameImg);
      this.storage.upload(nameImg, this.selectedImage).snapshotChanges().pipe(
        finalize(() => {
          fileRef.getDownloadURL().subscribe((url) => {

            this.leagueInfo.logo = url;

            this.leagueService.updateLeague(this.leagueInfo)
              .pipe(first())
              .subscribe({
                next: () => {
                  this.dialogRef.close();
                  // this.initDataSource();
                  this.common.sendMessage('League Info Updated!', 'success')
                },
                error: error => {
                  this.loading = false;
                  this.common.sendMessage(error.error.message, 'fail')
                }
              });

          });
        })
      ).subscribe();

    } else {
      this.leagueService.updateLeague(this.leagueInfo)
        .pipe(first())
        .subscribe({
          next: () => {
            this.dialogRef.close();
            // this.initDataSource();
            this.common.sendMessage('League Info Updated!', 'success')
          },
          error: error => {
            this.loading = false;
            this.common.sendMessage(error.error.message, 'fail')
          }
        });
    }
  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  public noWhitespaceValidator(control: FormControl) {
    const isWhitespace = (control.value || '').trim().length === 0;
    const isValid = !isWhitespace;
    return isValid ? null : { 'whitespace': true };
  }

}
