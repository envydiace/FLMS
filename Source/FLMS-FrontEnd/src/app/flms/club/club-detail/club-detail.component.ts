import { Component, OnInit } from '@angular/core';
import { ClubService } from './../club.service';
import { ClubDetailResponse } from 'src/app/models/club-detail-response.model';
import { map, tap } from 'rxjs/operators';
import { ClubDetail } from 'src/app/models/club-detail.model';
import { ActivatedRoute } from '@angular/router';
import { MatDialog } from '@angular/material/dialog';
import { PopUpDeleteClubComponent } from '../pop-up-delete-club/pop-up-delete-club.component';
import { PopUpEditClubComponent } from '../pop-up-edit-club/pop-up-edit-club.component';
import { AuthService } from 'src/app/auth/auth.service';

@Component({
  selector: 'app-club-detail',
  templateUrl: './club-detail.component.html',
  styleUrls: ['./club-detail.component.scss']
})
export class ClubDetailComponent implements OnInit {
  clubId: number;
  clubdetail: ClubDetail = null;
  defaultLogo: string = './../../../../assets/image/clubDefaultLogo.png';
  userRole: any;

  constructor(
    private clubService: ClubService,
    private route: ActivatedRoute,
    public dialog: MatDialog,
    public authen: AuthService,

  ) {
    this.route.queryParams.subscribe(params => {
      this.clubId = params['clubId'];
    });
  }

  ngOnInit(): void {
    this.initDataSource();
    this.userRole = this.authen.getUserRole();

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
      
    });
  }

  openEditClub(clubId: number): void {
    const dialogRef = this.dialog.open(PopUpEditClubComponent, {
      width: '80%',
      data: { clubId: clubId },
      disableClose: true
    });
    dialogRef.afterClosed().subscribe(result => {
      this.initDataSource();
      
    });
  }

}
