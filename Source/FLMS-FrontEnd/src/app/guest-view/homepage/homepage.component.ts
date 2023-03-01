import { Component, OnInit } from '@angular/core';
import { HomepageService } from './homepage.service';
import { first } from 'rxjs/operators';
import { ClubDetail } from 'src/app/models/club-detail.model';
import { ClubList } from 'src/app/models/club-list.model';

@Component({
  selector: 'app-homepage',
  templateUrl: './homepage.component.html',
  styleUrls: ['./homepage.component.scss']
})
export class HomepageComponent implements OnInit {
  clubs: ClubDetail[] = [];
  clubsTotal: number;

  constructor(
    private homeService: HomepageService
  ) { }

  ngOnInit(): void {
    this.getListClubFilter();
  }

  getListClubFilter() {
    this.homeService.getListClubFilter().pipe(first()).subscribe(
      clubList => {
        this.clubs = clubList.clubs,
        this.clubsTotal = clubList.total
      }
    );
  }
}