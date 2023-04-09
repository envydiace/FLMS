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
    private router: Router
  ) { }


  ngOnInit(): void {
    this.initDataSource();
    this.createForm();

    this.onChangeLeagueNameFilter();
    // this.onChangeFromFilter();
    // this.onChangeToFilter();
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
      'to': [null],
    });
  }

  onChangeLeagueNameFilter() {
    let leagueName = this.getControl('leagueName').value;
    let from = this.getControl('from').value;
    let to = this.getControl('to').value;

    if (leagueName == null) leagueName = '';
    if (from == null) from = '';
    if (to == null) to = '';

    this.getControl('leagueName').valueChanges
      .pipe(debounceTime(500), distinctUntilChanged())
      .subscribe((term) => {
        this.leagueService.findListLeagueFilter(term, 1, 8, from, to).pipe(
          map((leagueList: LeagueList) => this.leagueList = leagueList)
        ).subscribe()
      });
  }

  // onChangeFromFilter() {
  //   let leagueName = this.getControl('leagueName').value;
  //   let from = this.getControl('from').value;
  //   let to = this.getControl('to').value;

  //   if (leagueName == null) leagueName = '';
  //   if (from == null) from = '';
  //   if (to == null) to = '';

  //   this.getControl('from').valueChanges
  //     .pipe(debounceTime(500), distinctUntilChanged())
  //     .subscribe((term) => {
  //       this.leagueService.findListLeagueFilter(leagueName, 1, 8, term, to).pipe(
  //         map((leagueList: LeagueList) => this.leagueList = leagueList)
  //       ).subscribe()
  //     });
  // }

  // onChangeToFilter() {
  //   let leagueName = this.getControl('leagueName').value;
  //   let from = this.getControl('from').value;
  //   let to = this.getControl('to').value;

  //   if (leagueName == null) leagueName = '';
  //   if (from == null) from = '';
  //   if (to == null) to = '';

  //   this.getControl('to').valueChanges
  //     .pipe(debounceTime(500), distinctUntilChanged())
  //     .subscribe((term) => {
  //       this.leagueService.findListLeagueFilter(term, 1, 8, from, term).pipe(
  //         map((leagueList: LeagueList) => this.leagueList = leagueList)
  //       ).subscribe()
  //     });
  // }

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
    // if (this.leagueName == null) {
    //   page = page + 1;
    //   this.leagueService.findAll(page, size).pipe(map((leagueList: LeagueList) => this.leagueList = leagueList)).subscribe();
    // } else {
    //   page = page + 1;
    //   if (this.leagueName == null) this.leagueName = '';
    //   this.leagueService.findListLeagueFilter(this.leagueName, page, size).pipe(map((leagueList: LeagueList) => this.leagueList = leagueList)).subscribe();
    // }
  }

  navigateToLeagueDetail(id: number) {
    this.router.navigate(['/league-info'], { queryParams: { leagueId: id }});
  }
}


