
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { FeeDetail } from 'src/app/models/fee-detail.model';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { LeagueService } from '../../league.service';
import { Router } from '@angular/router';
import { Component, Inject, OnInit } from '@angular/core';
import { first, map } from 'rxjs/operators';
import { FeeDetailResponse } from './../../../../models/fee-response.model';
import { token } from 'src/app/models/token.model';
import { HttpHeaders } from '@angular/common/http';
import { CommonService } from 'src/app/common/common/common.service';
@Component({
  selector: 'app-pop-up-league-fee-detail',
  templateUrl: './pop-up-league-fee-detail.component.html',
  styleUrls: ['./pop-up-league-fee-detail.component.scss']
})
export class PopUpLeagueFeeDetailComponent implements OnInit {
  feeInfo: FeeDetail = null;
  form: FormGroup;
  loading = false;
  submitted = false;


  token: token;
  private headers: HttpHeaders;

  constructor(
    private formBuilder: FormBuilder,
    private LeagueService: LeagueService,
    private router: Router,
    public commonService: CommonService,
    public dialogRef: MatDialogRef<PopUpLeagueFeeDetailComponent>,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      leagueFeeId: number;
    }
  ) {
    this.token = JSON.parse(localStorage.getItem('user'));
    this.headers = new HttpHeaders().set('Authorization', `Bearer ${this.token.accessToken}`);

    this.form = new FormGroup({
      leagueFeeId: new FormControl(),
      expenseName: new FormControl(),
      cost: new FormControl(),
      feeType: new FormControl(),
      feeKey: new FormControl()
    })
  }

  ngOnInit(): void {
    this.initDataSource();

    this.form = this.formBuilder.group({
      leagueFeeId: this.data.leagueFeeId,
      expenseName: ['', Validators.required],
      cost: ['', Validators.required],
      feeType: ['',],
      feeKey: ['',]
    })
  }

  get f() { return this.form.controls; }


  initDataSource() {
    this.LeagueService.getFeeDetail(this.data.leagueFeeId).pipe(
      map((res: FeeDetailResponse) => this.feeInfo = res.feeInfo)
    ).subscribe(response => {

      if (response != null) this.bindValueIntoForm(response);
    }
    );
  }
  bindValueIntoForm(res: FeeDetail) {
    this.form.controls['expenseName'].patchValue(res.expenseName);
    this.form.controls['cost'].patchValue(res.cost);
    this.form.controls['feeType'].patchValue(res.feeType);
    this.form.controls['feeKey'].patchValue(res.expenseKey);
    this.form.controls['feeKey'].disable();

  }

  public onSubmit() {
    this.submitted = true;

    // stop here if form is invalid
    if (this.form.invalid) {
      return;
    }

    let tempFee = {
      expenseName: this.form.controls['expenseName'].value,
      leagueFeeId: this.data.leagueFeeId,
      cost: this.form.controls['cost'].value,
      feeType: this.form.controls['feeType'].value,
      feeKey: this.form.controls['feeKey'].value
    }

    
    this.loading = true;
    this.LeagueService.editLeagueFee(tempFee)
      .pipe(first())
      .subscribe({
        next: () => {
          this.dialogRef.close();
          this.commonService.sendMessage('Update fee success!', 'success');
        },
        error: error => {
          this.commonService.sendMessage(error.error.message, 'fail');
          this.loading = false;
        },

      });

  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  getErrorexpenseName() {
    return this.form.get('expenseName').hasError('required') ? 'Field Name is required' : '';
  }
  getErrorCost() {
    return this.form.get('cost').hasError('required') ? 'Field cost is required' : '';
  }
}
