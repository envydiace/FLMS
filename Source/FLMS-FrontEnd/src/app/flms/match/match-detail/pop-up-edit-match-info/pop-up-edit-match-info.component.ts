import { Component, Inject, OnInit } from '@angular/core';

import { ActivatedRoute, Router } from '@angular/router';
import { first, map } from 'rxjs/operators';
import { MatchDetailResponse } from 'src/app/models/match-detail-response.model';
import { MatchDetail } from 'src/app/models/match-detail.model';
import { MatchService } from '../../match.service';
import { MatDialogRef, MAT_DIALOG_DATA, MatDialog } from '@angular/material/dialog';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { token } from 'src/app/models/token.model';
import { HttpHeaders } from '@angular/common/http';
import { CommonService } from 'src/app/common/common/common.service';
@Component({
  selector: 'app-pop-up-edit-match-info',
  templateUrl: './pop-up-edit-match-info.component.html',
  styleUrls: ['./pop-up-edit-match-info.component.scss']
})
export class PopUpEditMatchInfoComponent implements OnInit {
  matchDetail: MatchDetail = null;
  form: FormGroup;
  loading = false;
  submitted = false;

  token: token;
  private headers: HttpHeaders;

  constructor(
    private MatchService: MatchService,
    private route: ActivatedRoute,
    private formBuilder: FormBuilder,
    private router: Router,
    public dialogRe: MatDialog,
    public commonService: CommonService,
    public dialogRef: MatDialogRef<PopUpEditMatchInfoComponent>,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      matchId: number;
    }
  ) {
    this.token = JSON.parse(localStorage.getItem('user'));
    this.headers = new HttpHeaders().set('Authorization', `Bearer ${this.token.accessToken}`);
  
    this.form = new FormGroup({
      matchDate: new FormControl(),
      matchTime: new FormControl(),
      stadium: new FormControl(), 
      round: new FormControl(),
    })
   }

  ngOnInit(): void {
    this.initDataSource();

    this.form = this.formBuilder.group({
      matchId: this.data.matchId,
      matchDate: [null, Validators.required],
      matchTime: [null, [Validators.required, Validators.pattern('^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$')]],
      stadium: [null, [Validators.required, Validators.maxLength(100), this.noWhitespaceValidator]],
      round:[ null,]
    })
  }

  get f() { return this.form.controls; }

  initDataSource() {
    this.getMatchInfoById(this.data.matchId);
    
  }

  bindValueIntoForm(res: MatchDetail) {
    this.form.controls['matchDate'].patchValue(res.matchDate);
    this.form.controls['matchTime'].patchValue(res.matchTime);
    this.form.controls['stadium'].patchValue(res.stadium);
    this.form.controls['round'].patchValue(res.round);
    this.form.controls['round'].disable();
  }

  getMatchInfoById(matchId: number) {
    this.MatchService.getMatchInfoById(matchId).pipe(
      map ((res: MatchDetailResponse) => {
        this.matchDetail = res.match;
        this.bindValueIntoForm(res.match);
      }))
      .subscribe();
  }

  public onSubmit() {
    this.submitted = true;

    // stop here if form is invalid
    if (this.form.invalid) {
      return;
    }

    this.loading = true;
    this.MatchService.editMatchInfo(this.form.value)
      .pipe(first())
      .subscribe({
        next: response => {
          this.initDataSource();
          this.commonService.sendMessage(response.message, 'success');

          this.dialogRef.close()
        },
        error: error => {
          this.loading = false;
          this.commonService.sendMessage(error.error.message, 'fail');
        }
      });

  }

  public noWhitespaceValidator(control: FormControl) {
    const isWhitespace = (control.value || '').trim().length === 0;
    const isValid = !isWhitespace;
    return isValid ? null : { 'whitespace': true };
  }
}
