import { Component, OnInit } from '@angular/core';
import { map, tap } from 'rxjs/operators';
import { ActivatedRoute } from '@angular/router';
import { MatchService } from './../match.service';
import { ClubStats, MatchStats, UpdateStats } from './../../../models/match-statistics-model';
import { MatchStatisticsResponse } from './../../../models/match-statistic-response-model';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { Club } from 'src/app/models/match-schedule.model';

@Component({
  selector: 'app-pop-up-edit-match-stats',
  templateUrl: './pop-up-edit-match-stats.component.html',
  styleUrls: ['./pop-up-edit-match-stats.component.scss']
})
export class PopUpEditMatchStatsComponent implements OnInit {
  form: FormGroup;
  matchId: number;
  home: ClubStats;
  away: ClubStats;

  constructor(
    private MatchService: MatchService,
    private route: ActivatedRoute,
    private formBuilder: FormBuilder
  ) {
    this.form = new FormGroup({
      fullName: new FormControl(),
      phone: new FormControl(),
      address: new FormControl()
    })
   }

  ngOnInit(): void {
    this.form = this.formBuilder.group({
      fullName: ['', Validators.required],
      phone: ['', Validators.required],
      address: ['', Validators.required],
      email: ['', Validators.required]
    })
  }

  initDataSource() {
    
    this.MatchService.getMatchStatsById(this.matchId).pipe(map((res: MatchStatisticsResponse) => {
      this.home = res.home,
        this.away = res.away
    })).subscribe(() => {
      this.bindValueIntoFormForHome(this.home);
      this.bindValueIntoFormForAway(this.away);
    });
  }

  bindValueIntoFormForHome(res: ClubStats) {
    this.form.controls['shot'].patchValue(res.shot);
    this.form.controls['phone'].patchValue(res.shotOnTarget);
    this.form.controls['address'].patchValue(res.offside);
    this.form.controls['email'].patchValue(res.conner);
    this.form.controls['email'].patchValue(res.conner);
    this.form.controls['email'].patchValue(res.redCard);
    this.form.controls['email'].patchValue(res.yellowCard);
  }
  bindValueIntoFormForAway(res: ClubStats) {
    this.form.controls['shot'].patchValue(res.shot);
    this.form.controls['phone'].patchValue(res.shotOnTarget);
    this.form.controls['address'].patchValue(res.offside);
    this.form.controls['email'].patchValue(res.conner);
    this.form.controls['email'].patchValue(res.conner);
    this.form.controls['email'].patchValue(res.redCard);
    this.form.controls['email'].patchValue(res.yellowCard);
  }
}
