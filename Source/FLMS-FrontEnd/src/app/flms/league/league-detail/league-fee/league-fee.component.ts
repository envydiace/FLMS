import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { FeeDetail } from './../../../../models/fee-detail.model';
import { LeagueFeeResponse } from '../../../../models/fee-response.model';
import { LeagueService } from '../../league.service';
import { map, tap } from 'rxjs/operators';
import { MatchEvent } from '../../../../models/match-event-detail.model';
import { PopUpLeagueFeeDetailComponent } from '../pop-up-league-fee-detail/pop-up-league-fee-detail.component';
import { MatDialog } from '@angular/material/dialog';
import { CommonService } from 'src/app/common/common/common.service';
import { PopUpAddActualComponent } from '../../pop-up-add-actual/pop-up-add-actual.component';
import { PopUpAddPlanComponent } from './../../pop-up-add-plan/pop-up-add-plan.component';
@Component({
  selector: 'app-league-fee',
  templateUrl: './league-fee.component.html',
  styleUrls: ['./league-fee.component.scss']
})
export class LeagueFeeComponent implements OnInit {
  displayedColumns: string[] = ['expenseName', 'cost', 'expenseKey', 'editB']
  leagueId: number;
  plan: FeeDetail[] = [];
  actual: FeeDetail[] = [];
  planCostTotal: number = 0;
  actualCostTotal: number = 0;
  leagueFeeId: number;
  isActual: boolean = false;

  constructor(
    private route: ActivatedRoute,
    private LeagueService: LeagueService,
    public dialog: MatDialog,
    public commonService: CommonService

  ) {
    this.route.queryParams.subscribe(params => {
      this.leagueId = params['leagueId'];
    });
  }

  ngOnInit(): void {
    this.initDataSource();

  }

  initDataSource() {
    this.LeagueService.getLeagueFee(this.leagueId).pipe(
      map((res: LeagueFeeResponse) => {
        this.plan = res.plan,
          this.actual = res.actual

      })
    ).subscribe(res => {
      this.getTotal();
    });


  }

  getTotal() {
    this.planCostTotal = 0;
    this.actualCostTotal = 0;
    this.plan.forEach(element => {
      this.planCostTotal += element.cost;
    });
    this.actual.forEach(element => {
      this.actualCostTotal += element.cost;
    });
  }

  openEditFee(leagueFeeId: number): void {
    const dialogRef = this.dialog.open(PopUpLeagueFeeDetailComponent, {
      width: '50%',
      data: { leagueFeeId: leagueFeeId }
    });

    dialogRef.afterClosed().subscribe(result => {
      this.initDataSource();
      this.getTotal();
      console.log('The dialog was closed');
    });
  }



  openAddActual(leagueId: number): void {
    const dialogRef = this.dialog.open(PopUpAddActualComponent, {
      width: '50%',
      data: { leagueId: leagueId }
    });

    dialogRef.afterClosed().subscribe(result => {
      // this.initDataSource();
      // this.getTotal();
      console.log('The dialog was closed');
    });
  }

  openAddPlan(leagueId: number): void {
    const dialogRef = this.dialog.open(PopUpAddPlanComponent, {
      width: '50%',
      data: { leagueId: leagueId }
    });

    dialogRef.afterClosed().subscribe(result => {
      // this.initDataSource();
      // this.getTotal();
      console.log('The dialog was closed');
    });
  }

  // OpenEditIfActual(isActual: boolean):void{
  //   if(isActual == false){
  //     this.openAddPlan()
  //   }else{

  //   }
  // }
}
