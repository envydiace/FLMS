import { Component, OnInit } from '@angular/core';
import { HomepageService } from './homepage.service';
import { first } from 'rxjs/operators';
import { ClubDetail } from 'src/app/models/club-detail.model';
import { ClubList } from 'src/app/models/club-list.model';
import { LeagueDetail } from 'src/app/models/league-detail.model';

@Component({
  selector: 'app-homepage',
  templateUrl: './homepage.component.html',
  styleUrls: ['./homepage.component.scss']
})
export class HomepageComponent implements OnInit {
  clubs: ClubDetail[] = [];
  clubsTotal: number;
  defaultLogo: string = './../../../assets/image/default-logo.png';
  topLeaguePrizes: LeagueDetail[];

  constructor(
    private homeService: HomepageService
  ) { }

  ngOnInit(): void {
    this.initDataSource();
  }

  getListClubFilter() {
    this.homeService.getListClubFilter().pipe(first()).subscribe(
      clubList => {
        this.clubs = clubList.clubs,
          this.clubsTotal = clubList.total
      }
    );
  }

  initDataSource() {
    this.getListClubFilter();
    this.getTopLeaguePrize();
  }

  getTopLeaguePrize() {
    this.homeService.GetTopLeaguePrize().pipe(first()).subscribe(
      res => {
        this.topLeaguePrizes = res.topLeaguePrizes;
      }
    );
  }
}