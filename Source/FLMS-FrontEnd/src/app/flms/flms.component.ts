import { Component, OnInit } from '@angular/core';
import { AuthService } from '../auth/auth.service';

@Component({
  selector: 'app-flms',
  templateUrl: './flms.component.html',
  styleUrls: ['./flms.component.scss']
})
export class FlmsComponent implements OnInit {
  panelOpenState = false;
  userRole: any;

  constructor(
    private authService: AuthService
  ) { }

  ngOnInit(): void {
    this.userRole = this.authService.getUserRole();
  }

}
