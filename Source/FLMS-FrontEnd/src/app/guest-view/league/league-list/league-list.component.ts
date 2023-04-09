import { Component, OnInit } from '@angular/core';
import { LeagueDetailComponent } from '../league-detail/league-detail.component';
import { LeagueService } from './../league.service';
import { debounceTime, distinctUntilChanged, map, tap } from 'rxjs/operators';
import { LeagueDetail } from 'src/app/models/league-detail.model';
import { LeagueDetailResponse } from 'src/app/models/league-detail-response.model';
import { LeagueList } from 'src/app/models/league-list.model';
import { PageEvent } from '@angular/material/paginator';
import { Router } from '@angular/router';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';
import { DatePipe } from '@angular/common';
import { CommonService } from 'src/app/common/common/common.service';

@Component({
  selector: 'app-league-list',
  templateUrl: './league-list.component.html',
  styleUrls: ['./league-list.component.scss']
})
export class LeagueListComponent implements OnInit {
  leagueList: LeagueList = null;
  pageEvent: PageEvent;
  defaultLogo: string = './../../../../assets/image/default-logo.png';
  filterForm: FormGroup;

  constructor(
    private leagueService: LeagueService,
    private formBuilder: FormBuilder,
    private commonService: CommonService,
    private router: Router
  ) { }


  ngOnInit(): void {
    this.initDataSource();
    this.createForm();

    this.onChangeLeagueNameFilter();
  }

  initDataSource() {
    this.getLeague();
  }

  getControl(name: string) {
    return this.filterForm.get(name) as FormControl;
  }

  createForm() {
    this.filterForm = this.formBuilder.group({
      'leagueName': [null],
      'from': [null],
      'to': [null]
    });
  }

  onChangeLeagueNameFilter() {
    this.filterForm.valueChanges.pipe(
      debounceTime(500), distinctUntilChanged()
    ).subscribe((values: any) => {
      let leagueName = values.leagueName;
      let from = values.from;
      let to = values.to;

      if (leagueName == null) leagueName = '';
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

      this.leagueService.findListLeagueFilter(leagueName, 1, 8, from, to).pipe(
        map((leagueList: LeagueList) => this.leagueList = leagueList)
      ).subscribe();
    });
  }

  getLeague() {
    this.leagueService.findAll(1, 8).pipe(
      map((leagueList: LeagueList) =>
        this.leagueList = leagueList
      ))
      .subscribe();
  }

  onPaginateChange(event: PageEvent) {
    let page = event.pageIndex;
    let size = event.pageSize;
    let leagueName = this.getControl('leagueName').value;
    let from = this.getControl('from').value;
    let to = this.getControl('to').value;

    if (leagueName == null && from == null && to == null) {
      page = page + 1;
      this.leagueService.findAll(page, size).pipe(map((leagueList: LeagueList) => this.leagueList = leagueList)).subscribe();
    } else {
      page = page + 1;
      if (leagueName == null) leagueName = '';

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
      this.leagueService.findListLeagueFilter(leagueName, page, size, from, to).pipe(
        map((leagueList: LeagueList) => this.leagueList = leagueList))
        .subscribe();
    }
  }

  navigateToLeagueDetail(id: number) {
    this.router.navigate(['/league-info'], { queryParams: { leagueId: id } });
  }
}


