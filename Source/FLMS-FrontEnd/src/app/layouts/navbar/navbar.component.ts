import { Component, OnInit } from '@angular/core';
import { map } from 'rxjs/operators';
import { AuthService } from 'src/app/auth/auth.service';
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
    private authService: AuthService
  ) { 
    this.token = JSON.parse(localStorage.getItem('user'));
  }

  ngOnInit(): void {
    if(this.token != null) {
      this.getCurrentUser();
    }
    
  }

  getCurrentUser() {
    this.authService.getCurrentUser().pipe(
      map((res: UserProfileResponse) => this.user = res.userProfile)
    ).subscribe();
  }

  logout(){
    this.authService.logout();
  }
}
