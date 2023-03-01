import { Component, OnInit } from '@angular/core';
import { ClubService } from './../club.service';
import { ClubDetailResponse } from 'src/app/models/club-detail-response.model';
import { map, tap } from 'rxjs/operators';
import { ClubDetail } from 'src/app/models/club-detail.model';



@Component({
  selector: 'app-club-detail',
  templateUrl: './club-detail.component.html',
  styleUrls: ['./club-detail.component.scss']
})
export class ClubDetailComponent implements OnInit {
  linkFb: string = 'https://www.facebook.com/profile.php?id=100009422590770';
  
  clubdetail: ClubDetail = null;

  constructor(
    private clubService: ClubService
  ) { }

  ngOnInit(): void {
    this.initDataSource();
  }
  tabLoadTimes: Date[] = [];

  getTimeLoaded(index: number) {
    if (!this.tabLoadTimes[index]) {
      this.tabLoadTimes[index] = new Date();
    }

    return this.tabLoadTimes[index];
  }

  initDataSource() {
    this.clubService.getdetailinfo(1).pipe(
      map((res: ClubDetailResponse) => this.clubdetail = res.clubInfo)
    ).subscribe();
  }

}


