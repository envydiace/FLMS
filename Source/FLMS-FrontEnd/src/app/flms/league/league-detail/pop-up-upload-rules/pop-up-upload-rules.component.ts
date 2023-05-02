import { formatDate } from '@angular/common';
import { Component, Inject, OnInit } from '@angular/core';
import { AngularFireStorage } from '@angular/fire/storage';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { finalize, first } from 'rxjs/operators';
import { CommonService } from 'src/app/common/common/common.service';
import { LeagueService } from '../../league.service';
import { ConfirmFeeComponent } from '../confirm-fee/confirm-fee.component';
import { AuthService } from 'src/app/auth/auth.service';

@Component({
  selector: 'app-pop-up-upload-rules',
  templateUrl: './pop-up-upload-rules.component.html',
  styleUrls: ['./pop-up-upload-rules.component.scss']
})
export class PopUpUploadRulesComponent implements OnInit {
  imgSrc: string = './../../../../../assets/image/default-logo.png';
  logo: string;
  selectedImage: any = null;
  loading = false;

  constructor(
    public commonService: CommonService,
    public authService: AuthService,
    public dialogRef: MatDialogRef<ConfirmFeeComponent>,
    private LeagueService: LeagueService,
    @Inject(AngularFireStorage) private storage: AngularFireStorage,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      leagueId: number;
      leagueName: string;
      leagueLogo: string;
    }
  ) { }

  ngOnInit(): void {
  }

  onSubmit() {
    this.loading = true;
    let userId = this.authService.getUserId();
    const nameImg = 'league/' + userId + '/' + this.data.leagueName + '/rules/' + this.getCurrentDateTime() + this.selectedImage.name;
    const fileRef = this.storage.ref(nameImg);

    this.storage.upload(nameImg, this.selectedImage).snapshotChanges().pipe(
      finalize(() => {
        fileRef.getDownloadURL().subscribe((url) => {
          this.LeagueService.uploadRules(this.data.leagueId, url)
            .pipe(first()).subscribe({
              next: response => {
                this.dialogRef.close();
                this.commonService.sendMessage(response.message, 'success');
              },
              error: error => {
                this.loading = false;
                this.commonService.sendMessage(error.error.message, 'fail');
              }
            });
        });
      })
    ).subscribe();

  }

  getCurrentDateTime(): string {
    return formatDate(new Date(), 'dd-MM-yyyy', 'en-US');
  }

  showPreview(event: any) {
    if (event.target.files && event.target.files[0]) {
      let file = event.target.files[0];
      if (file.type == "application/pdf" && file.size < 5000000) {
        console.log('Correct');
        const reader = new FileReader();
        reader.onload = (e: any) => this.imgSrc = e.target.result;
        reader.readAsDataURL(event.target.files[0]);
        this.selectedImage = event.target.files[0];
      } else {
        this.commonService.sendMessage('Invalid File', 'fail');
      }
    } else {
      this.imgSrc = './../../../../../assets/image/default-logo.png';
      this.selectedImage = null;
    }
  }

}
