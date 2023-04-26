import { Component, Input, OnInit, ViewChild } from '@angular/core';
import { MatchSchedule } from '../../../../models/match-schedule.model';
import { LeagueService } from '../../league.service';
import { debounceTime, distinctUntilChanged, map, tap } from 'rxjs/operators';
import { MatchScheduleResponse } from '../../../../models/match-schedule-response.model';
import { ActivatedRoute, Router } from '@angular/router';

import { PopUpEditMatchInfoComponent } from 'src/app/flms/match/match-detail/pop-up-edit-match-info/pop-up-edit-match-info.component';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ConfirmIsFinishComponent } from '../../pop-up-confirm-is-finish/pop-up-confirm-is-finish.component';
import { CommonService } from 'src/app/common/common/common.service';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';
import { AuthService } from 'src/app/auth/auth.service';

@Component({
  selector: 'app-league-schedule',
  templateUrl: './league-schedule.component.html',
  styleUrls: ['./league-schedule.component.scss']
})
export class LeagueScheduleComponent implements OnInit {
  displayedColumns: string[] = ['time', 'matchDate', 'home.name', 'vs', 'away.name', 'round', 'stadium', 'action'];

  displayedColumnsC: string[] = ['time', 'matchDate', 'home.name', 'vs', 'away.name', 'round', 'stadium'];
  leagueId: number;
  matchId: number;
  listMatch = new MatTableDataSource<MatchSchedule>();
  defaultLogo: string = './../../../../assets/image/clubDefaultLogo.png';
  filterForm: FormGroup;
  userRole: any;
  @Input() leagueName: string;

  @ViewChild(MatPaginator) paginator: MatPaginator;
  @ViewChild(MatSort) sort: MatSort;

  constructor(
    private route: ActivatedRoute,
    private LeagueService: LeagueService,
    private formBuilder: FormBuilder,
    private commonService: CommonService,
    private router: Router,
    public dialog: MatDialog,
    public authen: AuthService,
  ) {
    this.route.queryParams.subscribe(params => {
      this.leagueId = params['leagueId'];
    });
  }

  ngOnInit(): void {
    this.initDataSource();
    this.userRole = this.authen.getUserRole();
    this.createForm();
    this.onChangeFilter();
  }

  ngAfterViewInit() {
    this.listMatch.paginator = this.paginator;

    this.listMatch.sortingDataAccessor = (item, property) => {
      switch(property) {
        case 'home.name': return item.home.name;
        case 'away.name': return item.away.name;
        default: return item[property];
      }
    };
  
    this.listMatch.sort = this.sort;
  }

  initDataSource() {
    this.LeagueService.getmatch(this.leagueId, '', '', '').pipe(
      map((res: MatchScheduleResponse) => this.listMatch.data = res.listMatch)
    ).subscribe();
  }

  getControl(name: string) {
    return this.filterForm.get(name) as FormControl;
  }

  createForm() {
    this.filterForm = this.formBuilder.group({
      'clubName': [null],
      'from': [null],
      'to': [null]
    });
  }

  onChangeFilter() {
    this.filterForm.valueChanges.pipe(
      debounceTime(500), distinctUntilChanged()
    ).subscribe((values: any) => {
      let clubName = values.clubName;
      let from = values.from;
      let to = values.to;

      if (clubName == null) clubName = '';
      if (from != null) {
        from = this.commonService.addHoursToDate(from).toISOString();
      } else {
        from = '';
      }
      if (to != null) {
        to = this.commonService.addHoursToDate(to).toISOString();
      } else {
        to = '';
      }

      this.LeagueService.getmatch(this.leagueId, from, to, clubName).pipe(
        map((res: MatchScheduleResponse) => this.listMatch.data = res.listMatch)
      ).subscribe();
    });
  }

  navigateToMatchDetail(id: number) {
    this.router.navigate(['/manager/match-detail'], { queryParams: { matchId: id } });
  }

  openEditMatchInfo(matchId: number): void {
    const dialogRef = this.dialog.open(PopUpEditMatchInfoComponent, {
      width: '50%',
      data: { matchId: matchId }
    });

    dialogRef.afterClosed().subscribe(result => {
      this.initDataSource();
      console.log('The dialog was closed');
    });
  }

  openDialogConfirmIsFinished(matchId: number): void {
    const dialogRef = this.dialog.open(ConfirmIsFinishComponent, {
      width: '50%',
      data: { matchId: matchId }
    });
    dialogRef.afterClosed().subscribe(result => {
      this.initDataSource();
      console.log('The dialog was closed');
    });
  }

  exportLeagueSchedule() {
    this.LeagueService.exportLeagueSchedule(this.leagueId).subscribe(res => {
      let fileName = this.leagueName + '_League_Schedule';
      this.commonService.downLoadFile(res, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName);
      // this.downLoadFile(res, 'application/octet-stream');
    });
  }

  clearFilter() {
    this.getControl('clubName').patchValue(null);
    this.getControl('from').patchValue(null);
    this.getControl('to').patchValue(null);
  }
}
