import { Component, Input, OnInit, ViewChild } from '@angular/core';
import { MatchSchedule } from 'src/app/models/match-schedule.model';
import { LeagueService } from '../../league.service';
import { debounceTime, distinctUntilChanged, map, tap } from 'rxjs/operators';
import { MatchScheduleResponse } from 'src/app/models/match-schedule-response.model';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonService } from 'src/app/common/common/common.service';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';

@Component({
  selector: 'app-league-schedule',
  templateUrl: './league-schedule.component.html',
  styleUrls: ['./league-schedule.component.scss']
})
export class LeagueScheduleComponent implements OnInit {
  displayedColumns: string[] = ['time', 'matchDate', 'home.name', 'vs', 'away.name', 'round', 'stadium'];
  leagueId: number;
  listMatch = new MatTableDataSource<MatchSchedule>();
  defaultLogo: string = './../../../../assets/image/clubDefaultLogo.png';
  filterForm: FormGroup;
  @Input() leagueName: string;

  @ViewChild(MatPaginator) paginator: MatPaginator;
  @ViewChild(MatSort) sort: MatSort;

  constructor(
    private route: ActivatedRoute,
    private LeagueService: LeagueService,
    private formBuilder: FormBuilder,
    private commonService: CommonService,
    private router: Router
  ) {
    this.route.queryParams.subscribe(params => {
      this.leagueId = params['leagueId'];
    });
  }

  ngOnInit(): void {
    this.initDataSource();
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

  exportLeagueSchedule() {
    this.LeagueService.exportLeagueSchedule(this.leagueId).subscribe(res => {
      let fileName = this.leagueName + '_League_Schedule';
      this.commonService.downLoadFile(res, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName);
      // this.downLoadFile(res, 'application/octet-stream');
    });
  }

  navigateToMatchDetail(id: number) {
    this.router.navigate(['/match-info'], { queryParams: { matchId: id } });
  }

  clearFilter() {
    this.getControl('clubName').patchValue(null);
    this.getControl('from').patchValue(null);
    this.getControl('to').patchValue(null);
  }
}
