import { Component, OnInit, ViewChild } from '@angular/core';
import { ClubService } from './../club.service';
import { ClubList } from 'src/app/models/club-list.model';
import { debounceTime, distinctUntilChanged, map, tap } from 'rxjs/operators';
import { PageEvent } from '@angular/material/paginator';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/auth/auth.service';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-club-list',
  templateUrl: './club-list.component.html',
  styleUrls: ['./club-list.component.scss']
})
export class ClubListComponent implements OnInit {
  // clubName: string = null;
  // managerName: string = null;
  clubList: ClubList = null;
  pageEvent: PageEvent;
  defaultLogo: string = './../../../../assets/image/clubDefaultLogo.png';
  userRole: string;
  filterForm: FormGroup;

  constructor(
    private clubService: ClubService,
    private formBuilder: FormBuilder,
    private router: Router,
    private authService: AuthService,

  ) { }

  ngOnInit(): void {
    this.initDataSource();
    this.createForm();

    this.userRole = this.authService.getUserRole();

    this.onChangeClubNameFilter();
    this.onChangeManagerNameFilter();
  }

  getControl(name: string) {
    return this.filterForm.get(name) as FormControl;
  }

  createForm() {
    this.filterForm = this.formBuilder.group({
      'clubName': [null],
      'managerName': [null],
    });
  }

  onChangeClubNameFilter() {
    let clubName = this.getControl('clubName').value;
    let managerName = this.getControl('managerName').value;

    if (clubName == null) clubName = '';
    if (managerName == null) managerName = '';

    this.getControl('clubName').valueChanges
      .pipe(debounceTime(500), distinctUntilChanged())
      .subscribe((term) => {
        this.clubService.getListClubFilter(term, managerName, 1, 8).pipe(
          map((clubList: ClubList) => this.clubList = clubList)
        ).subscribe()
      });
  }

  onChangeManagerNameFilter() {
    let clubName = this.getControl('clubName').value;
    let managerName = this.getControl('managerName').value;

    if (clubName == null) clubName = '';
    if (managerName == null) managerName = '';

    this.getControl('managerName').valueChanges
      .pipe(debounceTime(500), distinctUntilChanged())
      .subscribe((term) => {
        this.clubService.getListClubFilter(clubName, term, 1, 8).pipe(
          map((clubList: ClubList) => this.clubList = clubList)
        ).subscribe()
      });
  }

  initDataSource() {
    this.clubService.findAll(1, 8).pipe(
      map((clubList: ClubList) => this.clubList = clubList)
    ).subscribe();
  }

  onPaginateChange(event: PageEvent) {
    let page = event.pageIndex;
    let size = event.pageSize;
    let clubName = this.getControl('clubName').value;
    let managerName = this.getControl('managerName').value;
    if (clubName == null && managerName == null) {
      page = page + 1;
      this.clubService.findAll(page, size).pipe(
        map((clubList: ClubList) => this.clubList = clubList)
      ).subscribe();
    } else {
      page = page + 1;
      if (clubName == null || clubName == undefined) clubName.value = '';
      if (managerName == null || managerName == undefined) managerName = '';
      this.clubService.getListClubFilter(clubName, managerName, page, size).pipe(
        map((clubList: ClubList) => this.clubList = clubList)
      ).subscribe()
    }

  }
  
  navigateToClubDetail(id: number) {
    this.router.navigate(['/club-info'], { queryParams: { clubId: id } });
  }


}
