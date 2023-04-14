import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { RequestService } from './request.service';
import { map, first } from 'rxjs/operators';
import { RequestListResponse } from 'src/app/models/request-list-response.model';
import { Request } from 'src/app/models/request.model';
import { MatSort } from '@angular/material/sort';
import { token } from 'src/app/models/token.model';
import { PopUpReuestConfirmationComponent } from './pop-up-reuest-confirmation/pop-up-reuest-confirmation.component';
import { MatDialog } from '@angular/material/dialog';

@Component({
  selector: 'app-request-list',
  templateUrl: './request-list.component.html',
  styleUrls: ['./request-list.component.scss']
})
export class RequestListComponent implements OnInit, AfterViewInit {
  displayedColumns: string[] = ['clubName', 'leagueName', 'requestDate', 'requestType', 'requestStatus', 'actions'];
  from: string = '';
  to: string = '';
  type: string = '';
  status: string = '';
  requestListResponse: RequestListResponse;
  dataSource = new MatTableDataSource<Request>();
  token: token;
  userRole: string = null;
  @ViewChild(MatPaginator) paginator: MatPaginator;
  @ViewChild(MatSort) sort: MatSort;

  constructor(
    private requestService: RequestService,
    public dialog: MatDialog,

  ) {
    this.token = JSON.parse(localStorage.getItem('user'));
  }

  ngOnInit(): void {
    this.initDataSource();
    this.dataSource.sort = this.sort;
    this.userRole = this.token.role;
  }

  ngAfterViewInit() {
    this.dataSource.paginator = this.paginator;
    this.dataSource.sort = this.sort;
  }

  initDataSource() {
    this.requestService.getRequestList(this.from, this.to, this.type, this.status).pipe(
      map((requestListResponse: RequestListResponse) => this.dataSource.data = requestListResponse.requests)
    ).subscribe();
  }

  sendRequestAction(requestId: number, action: string) {
    this.requestService.updateRequestStatus(requestId, action)
      .pipe(first())
      .subscribe({
        next: () => {
          this.initDataSource();
        },
        error: error => {

        }
      });
  }


  openRequestConfirmation(requestId: number, action: string): void {
    const dialogRef = this.dialog.open(PopUpReuestConfirmationComponent, {
      width: '60%',
      data: { requestId:  requestId, action: action},
      disableClose: true
    });
    dialogRef.afterClosed().subscribe(result => {
      this.initDataSource();
      console.log('The dialog was closed');
    });
  }
}