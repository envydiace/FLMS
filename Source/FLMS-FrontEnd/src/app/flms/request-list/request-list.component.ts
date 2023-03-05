import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { RequestService } from './request.service';
import { map } from 'rxjs/operators';
import { RequestListResponse } from 'src/app/models/request-list-response.model';
import { Request } from 'src/app/models/request.model';
import { MatSort } from '@angular/material/sort';

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

  @ViewChild(MatPaginator) paginator: MatPaginator;
  @ViewChild(MatSort) sort: MatSort;

  constructor(
    private requestService: RequestService
  ) { 
  }

  ngOnInit(): void {
    this.initDataSource();
    this.dataSource.sort = this.sort;
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
}