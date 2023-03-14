import { formatDate } from '@angular/common';
import { Component, Inject, OnInit } from '@angular/core';
import { AngularFireStorage } from '@angular/fire/storage';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Router } from '@angular/router';
import { finalize, first, map } from 'rxjs/operators';
import { FeeDetail, LeagueClubFee } from 'src/app/models/fee-detail.model';
import { LeagueClubFeeResponse, LeagueFeeResponse } from 'src/app/models/fee-response.model';
import { LeagueService } from '../../league.service';

@Component({
  selector: 'app-confirm-fee',
  templateUrl: './confirm-fee.component.html',
  styleUrls: ['./confirm-fee.component.scss']
})
export class ConfirmFeeComponent implements OnInit {
  displayedColumns: string[] = ['feeType', 'expenseName', 'cost']
  plan: FeeDetail[] = [];
  actual: FeeDetail[] = [];
  planCostTotal: number = 0;
  actualCostTotal: number = 0;
  leagueId: number;
  noParticipate: number;
  total: number;
  clubName: string;
  leagueName: string;
  logo: string;

  loading = false;
  submitted = false;
  selectedImage: any = null;


  constructor(
    private formBuilder: FormBuilder,
    private LeagueService: LeagueService,
    private router: Router,
    public dialogRef: MatDialogRef<ConfirmFeeComponent>,
    @Inject(AngularFireStorage) private storage: AngularFireStorage,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      clubId: number;
      leagueId: string;
    }
  ) {
  }

  ngOnInit(): void {
    this.initDataSource();
  }
  initDataSource() {
    this.leagueId = +this.data.leagueId;

    this.LeagueService.getLeagueClubFees(this.leagueId, this.data.clubId).pipe(
      map((res: LeagueClubFeeResponse) => {
        this.plan = res.plan,
          this.noParticipate = res.noParticipate,
          this.total = res.total,
          this.clubName = res.clubName,
          this.leagueName = res.leagueName
      })
    ).subscribe(res => {

    });
  }

  showPreview(event: any) {
    this.selectedImage = event.target.files[0];
  }

  onSubmit() {
    this.submitted = true;

    // stop here if form is invalid
    // if (this.form.invalid) {
    //   return;
    // }

    this.loading = true;
    const nameImg = 'league/' + this.leagueName + '/evidence/' + this.clubName + '/' + this.getCurrentDateTime() + this.selectedImage.name;
    const fileRef = this.storage.ref(nameImg);

    this.storage.upload(nameImg, this.selectedImage).snapshotChanges().pipe(
      finalize(() => {
        fileRef.getDownloadURL().subscribe((url) => {
          const fee: LeagueClubFee = {
            leagueId: this.leagueId,
            clubId: this.data.clubId,
            evidence: url
          }

          this.LeagueService.confirmRegistFee(fee)
            .pipe(first()).subscribe({
              next: () => {
                this.router.navigate(['/manager/my-league'])
              },
              error: error => {
                this.loading = false;
              }
            });

        });
      })
    ).subscribe();
  }

  getCurrentDateTime(): string {
    return formatDate(new Date(), 'dd-MM-yyyy', 'en-US');
  }
}
