import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { FeeDetail } from 'src/app/models/fee-detail.model';
import { LeagueFeeResponse } from 'src/app/models/fee-response.model';
import { LeagueService } from '../../league.service';
import { map, tap } from 'rxjs/operators';

@Component({
  selector: 'app-league-fee',
  templateUrl: './league-fee.component.html',
  styleUrls: ['./league-fee.component.scss']
})
export class LeagueFeeComponent implements OnInit {
  displayedColumns: string[] = ['expenseName', 'cost', 'expenseKey']
  leagueId: number;
  plan: FeeDetail[] = [];
  actual: FeeDetail[] = [];
  planCostTotal: number = 0;
  actualCostTotal: number = 0;

  constructor(
    private route: ActivatedRoute,
    private LeagueService: LeagueService
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
}
