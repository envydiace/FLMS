import { Component, Inject, OnInit } from '@angular/core';
import { map, tap } from 'rxjs/operators';
import { first } from 'rxjs/operators';
import { ActivatedRoute } from '@angular/router';
import { MatchService } from './../match.service';
import { ClubStats, MatchStats } from './../../../models/match-statistics-model';
import { MatchStatisticsResponse } from './../../../models/match-statistic-response-model';
import { FormBuilder, FormGroup, FormControl, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA, MatDialog } from '@angular/material/dialog';
import { CommonService } from './../../../common/common/common.service';

@Component({
  selector: 'app-pop-up-edit-match-stats',
  templateUrl: './pop-up-edit-match-stats.component.html',
  styleUrls: ['./pop-up-edit-match-stats.component.scss']
})
export class PopUpEditMatchStatsComponent implements OnInit {
  form: FormGroup;
  home: ClubStats;
  away: ClubStats;
  displayedColumns: string[] = ['home', 'type', 'away'];
  dataSource = ELEMENT_DATA;
  loading = false;

  constructor(
    private MatchService: MatchService,
    private route: ActivatedRoute,
    private formBuilder: FormBuilder,
    private commonService: CommonService,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      matchId: number;
    },
    public dialogRef: MatDialogRef<PopUpEditMatchStatsComponent>
  ) {
    this.form = new FormGroup({
      shothome: new FormControl(),
      shotaway: new FormControl(),
      shotOnTargethome: new FormControl(),
      shotOnTargetaway: new FormControl(),
      connerhome: new FormControl(),
      conneraway: new FormControl(),
      foulhome: new FormControl(),
      foulaway: new FormControl(),
      offsidehome: new FormControl(),
      offsideaway: new FormControl(),
      redhome: new FormControl(),
      redaway: new FormControl(),
      yellowhome: new FormControl(),
      yellowaway: new FormControl()
    })
  }

  ngOnInit(): void {
    this.form = this.formBuilder.group({
      shothome: ['', [Validators.required,Validators.min(0)]],
      shotaway: ['', [Validators.required,Validators.min(0)]],
      shotOnTargethome: ['', [Validators.required,Validators.min(0)]],
      shotOnTargetaway: ['', [Validators.required,Validators.min(0)]],
      connerhome: ['', [Validators.required,Validators.min(0)]],
      conneraway: ['', [Validators.required,Validators.min(0)]],
      foulhome: ['', [Validators.required,Validators.min(0)]],
      foulaway: ['', [Validators.required,Validators.min(0)]],
      offsidehome: ['', [Validators.required,Validators.min(0)]],
      offsideaway: ['', [Validators.required,Validators.min(0)]],
      redhome: ['', [Validators.required,Validators.min(0)]],
      redaway: ['', [Validators.required,Validators.min(0)]],
      yellowhome: ['', [Validators.required,Validators.min(0)]],
      yellowaway: ['', [Validators.required,Validators.min(0)]]
    });
    this.initDataSource();
  }

  initDataSource() {

    this.MatchService.getMatchStatsById(this.data.matchId).pipe(map((res: MatchStatisticsResponse) => {
      this.home = res.home,
        this.away = res.away
    })).subscribe(() => {
      this.bindDataToHome(this.home);
      this.bindDataToAway(this.away);
    });
  }

  bindDataIntoHome() {
    this.home = {
      matchId: null,
      isHome: true,
      shot: this.getControl('shothome').value,
      shotOnTarget: this.getControl('shotOnTargethome').value,
      conner: this.getControl('connerhome').value,
      foul: this.getControl('foulhome').value,
      offside: this.getControl('offsidehome').value,
      redCard: this.getControl('redhome').value,
      yellowCard: this.getControl('yellowhome').value,
    }
  }

  bindDataIntoAway() {
    this.away = {
      matchId: null,
      isHome: false,
      shot: this.getControl('shotaway').value,
      shotOnTarget: this.getControl('shotOnTargetaway').value,
      conner: this.getControl('conneraway').value,
      foul: this.getControl('foulaway').value,
      offside: this.getControl('offsideaway').value,
      redCard: this.getControl('redaway').value,
      yellowCard: this.getControl('yellowaway').value,
    }
  }

  getControl(name: string) {
    return this.form.get(name) as FormControl;
  }

  bindDataToHome(home: ClubStats) {
    ELEMENT_DATA[0].home = home.shot;
    ELEMENT_DATA[1].home = home.shotOnTarget;
    ELEMENT_DATA[2].home = home.conner;
    ELEMENT_DATA[3].home = home.foul;
    ELEMENT_DATA[4].home = home.offside;
    ELEMENT_DATA[6].home = home.redCard;
    ELEMENT_DATA[5].home = home.yellowCard;

    this.getControl('shothome').patchValue(home.shot);
    this.getControl('shotOnTargethome').patchValue(home.shotOnTarget);
    this.getControl('connerhome').patchValue(home.conner);
    this.getControl('foulhome').patchValue(home.foul);
    this.getControl('offsidehome').patchValue(home.offside);
    this.getControl('redhome').patchValue(home.redCard);
    this.getControl('yellowhome').patchValue(home.yellowCard);
  }

  bindDataToAway(away: ClubStats) {
    ELEMENT_DATA[0].away = away.shot;
    ELEMENT_DATA[1].away = away.shotOnTarget;
    ELEMENT_DATA[2].away = away.conner;
    ELEMENT_DATA[3].away = away.foul;
    ELEMENT_DATA[4].away = away.offside;
    ELEMENT_DATA[6].away = away.redCard;
    ELEMENT_DATA[5].away = away.yellowCard;

    this.getControl('shotaway').patchValue(away.shot);
    this.getControl('shotOnTargetaway').patchValue(away.shotOnTarget);
    this.getControl('conneraway').patchValue(away.conner);
    this.getControl('foulaway').patchValue(away.foul);
    this.getControl('offsideaway').patchValue(away.offside);
    this.getControl('redaway').patchValue(away.redCard);
    this.getControl('yellowaway').patchValue(away.yellowCard);

  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  onSubmit() {
    this.bindDataIntoHome();
    this.bindDataIntoAway();
    // stop here if form is invalid
    // if (this.form.invalid) {
    //   return;
    // }
    const UpdateStats: MatchStatisticsResponse = {
      message: null,
      messageCode: null,
      matchId: this.data.matchId,
      home: this.home,
      away: this.away
    }

    this.loading = true;
    this.MatchService.updateMatchStats(UpdateStats)
      .pipe(first())
      .subscribe({
        next: () => {
          this.dialogRef.close();
          this.commonService.sendMessage('Update Successfully!', 'success');
        },
        error: error => {
          this.loading = false;
          this.commonService.sendMessage('Update Failed, please check your input!', 'fail');
        }
      });
  }


}

export interface PeriodicElement {
  home: number;
  type: string;
  away: number;
  homeControlName: string;
  awayControlName: string;
}

const ELEMENT_DATA: PeriodicElement[] = [
  { home: 0, type: 'Shots', away: 0, homeControlName: 'shothome', awayControlName: 'shotaway' },
  { home: 0, type: 'Shots On Target', away: 0, homeControlName: 'shotOnTargethome', awayControlName: 'shotOnTargetaway' },
  { home: 0, type: 'Conner', away: 0, homeControlName: 'connerhome', awayControlName: 'conneraway' },
  { home: 0, type: 'Foul', away: 0, homeControlName: 'foulhome', awayControlName: 'foulaway' },
  { home: 0, type: 'Offside', away: 0, homeControlName: 'offsidehome', awayControlName: 'offsideaway' },
  { home: 0, type: 'Red Card', away: 0, homeControlName: 'redhome', awayControlName: 'redaway' },
  { home: 0, type: 'Yellow Card', away: 0, homeControlName: 'yellowhome', awayControlName: 'yellowaway' }
];