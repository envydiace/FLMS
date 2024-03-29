import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { map } from 'rxjs/operators';
import { AuthService } from 'src/app/auth/auth.service';
import { CommonService } from 'src/app/common/common/common.service';
import { token } from 'src/app/models/token.model';
import { User } from 'src/app/models/user';
import { UserProfileResponse } from 'src/app/models/user-profile-response.model';
import { UserProfile } from 'src/app/models/user-profile.model';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.scss']
})
export class NavbarComponent implements OnInit {
  user: UserProfile;
  token: token;
  defaultLogo: string = './../../../assets/image/default-avatar-profile-icon.webp';

  constructor(
    private commonService: CommonService,
    public router: Router,
    private authService: AuthService
  ) {
    this.token = JSON.parse(localStorage.getItem('user'));
  }

  ngOnInit(): void {
    if (this.token != null) {
      this.getCurrentUser();
    }

  }

  getCurrentUser() {
    this.authService.getCurrentUser().pipe(
      map((res: UserProfileResponse) => this.user = res.userProfile)
    ).subscribe({
      next: response => {
      },
      error: error => {
        if (error.status == '401') {
          this.commonService.sendMessage('Unauthorized', 'fail');
          localStorage.removeItem('user');
          this.router.navigate(['/login']);
        }
      }
    });
  }

  logout() {
    this.authService.logout();
  }
}
