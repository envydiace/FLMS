import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { FeeDetail } from './../../../../models/fee-detail.model';
import { LeagueFeeResponse } from '../../../../models/fee-response.model';
import { LeagueService } from '../../league.service';
import { first, map, tap } from 'rxjs/operators';
import { MatchEvent } from '../../../../models/match-event-detail.model';
import { PopUpLeagueFeeDetailComponent } from '../pop-up-league-fee-detail/pop-up-league-fee-detail.component';
import { MatDialog } from '@angular/material/dialog';
import { CommonService } from 'src/app/common/common/common.service';
import { PopUpAddActualComponent } from '../../pop-up-add-actual/pop-up-add-actual.component';
import { PopUpAddPlanComponent } from './../../pop-up-add-plan/pop-up-add-plan.component';
import { PopUpLeagueCostEditComponent } from '../pop-up-league-cost-edit/pop-up-league-cost-edit.component';
import { PopUpConfirmDeleteLeagueFeeComponent } from '../../pop-up-confirm-delete-league-fee/pop-up-confirm-delete-league-fee.component';
import { AuthService } from 'src/app/auth/auth.service';
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
  loading = false;
  userRole: any;


  constructor(
    private route: ActivatedRoute,
    private LeagueService: LeagueService,
    public dialog: MatDialog,
    public commonService: CommonService,
    public authen: AuthService,


  ) {
    this.route.queryParams.subscribe(params => {
      this.leagueId = params['leagueId'];
    });
  }

  ngOnInit(): void {
    this.initDataSource();
    this.userRole = this.authen.getUserRole();

  }

  initDataSource() {
    this.LeagueService.getLeagueFee(this.leagueId).pipe(
      map((res: LeagueFeeResponse) => {
        this.plan = res.plan,
          this.actual = res.actual,
          this.planCostTotal = res.totalPlanFee,
          this.actualCostTotal = res.totalActualFee


      })
    ).subscribe(res => {
      // 

    });


  }

  // getTotal() {
  //   this.planCostTotal = 0;
  //   this.actualCostTotal = 0;
  //   this.plan.forEach(element => {
  //     this.planCostTotal += element.cost;
  //   });
  //   this.actual.forEach(element => {
  //     this.actualCostTotal += element.cost;
  //   });
  // }

  openEditFee(leagueFeeId: number): void {
    const dialogRef = this.dialog.open(PopUpLeagueFeeDetailComponent, {
      width: '50%',
      data: { leagueFeeId: leagueFeeId }
    });

    dialogRef.afterClosed().subscribe(result => {
      this.initDataSource();
      // this.getTotal();
      
    });
  }

  openEditCost(leagueFeeId: number): void {
    const dialogRef = this.dialog.open(PopUpLeagueCostEditComponent, {
      width: '50%',
      data: { leagueFeeId: leagueFeeId }
    });

    dialogRef.afterClosed().subscribe(result => {
      this.initDataSource();
      // this.getTotal();
      
    });
  }

  openAddActual(leagueId: number): void {
    this.isActual = true
    const dialogRef = this.dialog.open(PopUpAddActualComponent, {
      width: '50%',
      data: {
        leagueId: leagueId,
        isActual: this.isActual,
        actual: this.actual
      },
      disableClose: true

    });

    dialogRef.afterClosed().subscribe(result => {
      // this.initDataSource();
      // this.getTotal();
      if (result != null || result != undefined) {
        this.loading = true;
        // this.actual = result

        this.LeagueService.editFee(leagueId, this.isActual, result).pipe(first())
          .subscribe({
            next: response => {
              this.loading = false;

              const newUserArray = this.actual;
              newUserArray.push(...result);
              this.actual = [...newUserArray];
              this.initDataSource();
              this.commonService.sendMessage('Add Actual Fee Success!', 'success');
            },
            error: error => {
              this.loading = false;
              this.commonService.sendMessage(error.error.message, 'fail');
            }
          })

      }

      
    });
  }

  openAddPlan(leagueId: number): void {
    this.isActual = false;
    const dialogRef = this.dialog.open(PopUpAddPlanComponent, {
      width: '50%',
      data: {
        leagueId: leagueId,
        isActual: this.isActual,
        plan: this.plan
      },
      disableClose: true

    });

    dialogRef.afterClosed().subscribe(result => {
      if (result != null || result != undefined) {
        this.loading = true;
        // this.plan = result

        this.LeagueService.editFee(leagueId, this.isActual, result).pipe(first())
          .subscribe({
            next: () => {
              this.loading = false;
              
              const newUserArray = this.plan;
              newUserArray.push(...result);
              this.plan = [...newUserArray];
              this.initDataSource();

              this.commonService.sendMessage('Add Plan Fee Success!', 'success');
            },
            error: error => {
              this.loading = false;
              this.commonService.sendMessage(error.error.message, 'fail');
            }
          })

      }
      //this.initDataSource();
      // this.getTotal();
      
    });
  }

  openConfirmedDeleteFee(leagueFeeId: number): void {
    const dialogRef = this.dialog.open(PopUpConfirmDeleteLeagueFeeComponent, {
      width: '40%',
      data: { leagueFeeId: leagueFeeId }
    });
    dialogRef.afterClosed().subscribe(result => {
      this.initDataSource();
    });
  }

}
