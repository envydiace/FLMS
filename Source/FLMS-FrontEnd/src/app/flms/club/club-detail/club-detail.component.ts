import { Component, OnInit } from '@angular/core';
import { ClubService } from './../club.service';
import { ClubDetailResponse } from 'src/app/models/club-detail-response.model';
import { map, tap } from 'rxjs/operators';
import { ClubDetail } from 'src/app/models/club-detail.model';
import { ActivatedRoute } from '@angular/router';
import { MatDialog } from '@angular/material/dialog';
import { PopUpDeleteClubComponent } from '../pop-up-delete-club/pop-up-delete-club.component';

@Component({
  selector: 'app-club-detail',
  templateUrl: './club-detail.component.html',
  styleUrls: ['./club-detail.component.scss']
})
export class ClubDetailComponent implements OnInit {
  linkFb: string = 'https://www.facebook.com/profile.php?id=100009422590770';
  clubId: number;
  clubdetail: ClubDetail = null;
  defaultLogo: string = './../../../../assets/image/clubDefaultLogo.png';

  constructor(
    private clubService: ClubService,
    private route: ActivatedRoute,
    public dialog: MatDialog
  ) { 
    this.route.queryParams.subscribe(params => {
      this.clubId = params['clubId'];
    });
  }

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
    this.clubService.getdetailinfo(this.clubId).pipe(
      map((res: ClubDetailResponse) => this.clubdetail = res.clubInfo)
    ).subscribe();

  }

  openDeleteClubPopup(clubId: number): void {
    const dialogRef = this.dialog.open(PopUpDeleteClubComponent, {
      width: '50%',
      data: { clubId: clubId }
    });
    dialogRef.afterClosed().subscribe(result => {
      console.log('The dialog was closed');
    });
  }

}
