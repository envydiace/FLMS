import { Component, OnInit } from '@angular/core';
import { ClubService } from './../club.service';
import { ClubDetailResponse } from 'src/app/models/club-detail-response.model';
import { map, tap } from 'rxjs/operators';
import { ClubDetail } from 'src/app/models/club-detail.model';
import { ActivatedRoute } from '@angular/router';
import { PopUpSendInvitationComponent } from './pop-up-send-invitation/pop-up-send-invitation.component';
import { MatDialog } from '@angular/material/dialog';


@Component({
  selector: 'app-club-detail',
  templateUrl: './club-detail.component.html',
  styleUrls: ['./club-detail.component.scss']
})
export class ClubDetailComponent implements OnInit {
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

  openSendInvitation(): void{
    const dialogRef = this.dialog.open(PopUpSendInvitationComponent, {
      width: '100%',
      data: { clubId: this.clubId}
    });

    dialogRef.afterClosed().subscribe(result => {
      console.log('The dialog was closed');
    });
  }

}


