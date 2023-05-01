import { formatDate } from '@angular/common';
import { Component, Inject, OnInit } from '@angular/core';
import { AngularFireStorage } from '@angular/fire/storage';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { finalize } from 'rxjs/operators';
import { CommonService } from 'src/app/common/common/common.service';

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

    // stop here if form is invalid
    // if (this.form.invalid) {
    //   return;
    // }

    this.loading = true;
    const nameImg = 'league/' + this.data.leagueId + '/evidence/'  + '/' + this.getCurrentDateTime() + this.selectedImage.name;
    const fileRef = this.storage.ref(nameImg);

    this.storage.upload(nameImg, this.selectedImage).snapshotChanges().pipe(
      finalize(() => {
        fileRef.getDownloadURL().subscribe((url) => {


          // this.LeagueService.confirmRegistFee(fee)
          //   .pipe(first()).subscribe({
          //     next: response => {
          //       this.dialogRef.close();
          //       this.commonService.sendMessage(response.message, 'success');
          //     },
          //     error: error => {
          //       this.loading = false;
          //       this.commonService.sendMessage(error.error.message, 'fail');
          //     }
          //   });

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
        this.commonService.sendMessage('Invalid Image', 'fail');
      }
    } else {
      this.imgSrc = './../../../../../assets/image/default-logo.png';
      this.selectedImage = null;
    }
  }

}
