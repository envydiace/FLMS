import { Component, OnInit, ViewChild } from '@angular/core';
import { ClubService } from './../club.service';
import { ClubList } from 'src/app/models/club-list.model';
import { map, tap } from 'rxjs/operators';
import { PageEvent } from '@angular/material/paginator';
import { Router } from '@angular/router';

@Component({
  selector: 'app-club-list',
  templateUrl: './club-list.component.html',
  styleUrls: ['./club-list.component.scss']
})
export class ClubListComponent implements OnInit {
  clubName: string = null;
  managerName: string = null;
  clubList: ClubList = null;
  pageEvent: PageEvent;
  defaultLogo: string = './../../../../assets/image/clubDefaultLogo.png';

  constructor(
    private clubService: ClubService,
    private router: Router
  ) { }

  ngOnInit(): void {
    this.initDataSource();
  }

  initDataSource() {
    this.clubService.findAll(1, 8).pipe(
      map((clubList: ClubList) => this.clubList = clubList)
    ).subscribe();
  }

  onPaginateChange(event: PageEvent) {
    let page = event.pageIndex;
    let size = event.pageSize;

    if (this.clubName == null) {
      page = page + 1;
      this.clubService.findAll(page, size).pipe(
        map((clubList: ClubList) => this.clubList = clubList)
      ).subscribe();
    } else {
      page = page + 1;
      if (this.clubName == null) this.clubName = '';
      if (this.managerName == null) this.managerName = '';
      this.clubService.getListClubFilter(this.clubName, this.managerName, page, size).pipe(
        map((clubList: ClubList) => this.clubList = clubList)
      ).subscribe()
    }

  }

  findClubsByName(clubName: string, managerName: string) {
    if (clubName == null) clubName = '';
    if (managerName == null) managerName = '';
    this.clubService.getListClubFilter(clubName, managerName, 1, 8).pipe(
      map((clubList: ClubList) => this.clubList = clubList)
    ).subscribe()
  }

  navigateToClubDetail(id: number) {
    this.router.navigate(['/club-info'], { queryParams: {clubId : id}});
  }


}
