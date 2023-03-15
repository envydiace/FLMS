import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { FeeDetail } from './../../../../models/fee-detail.model';
import { LeagueFeeResponse } from '../../../../models/fee-response.model';
import { LeagueService } from '../../league.service';
import { map, tap } from 'rxjs/operators';
import { MatchEvent } from '../../../../models/match-event-detail.model';
import { PopUpLeagueFeeDetailComponent } from '../pop-up-league-fee-detail/pop-up-league-fee-detail.component';
import { MatDialog } from '@angular/material/dialog';

@Component({
  selector: 'app-league-fee',
  templateUrl: './league-fee.component.html',
  styleUrls: ['./league-fee.component.scss']
})
export class LeagueFeeComponent implements OnInit {
  displayedColumns: string[] = ['expenseName', 'cost', 'expenseKey','editB']
  leagueId: number;
  plan: FeeDetail[] = [];
  actual: FeeDetail[] = [];
  planCostTotal: number = 0;
  actualCostTotal: number = 0;
  leagueFeeId:number;

  constructor(
    private route: ActivatedRoute,
    private LeagueService: LeagueService,
    public dialog: MatDialog

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
    this.plan.forEach(element => {
      this.planCostTotal += element.cost;
    });
    this.actual.forEach(element => {
      this.actualCostTotal += element.cost;
    });
  }

openEditFee(leagueFeeId: number): void{
    const dialogRef = this.dialog.open(PopUpLeagueFeeDetailComponent, {
      width: '50%',
      data: { leagueFeeId: leagueFeeId}
    });

    dialogRef.afterClosed().subscribe(result => {
      console.log('The dialog was closed');
    });
  }
  
}
