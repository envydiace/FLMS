import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, UrlTree, Router } from '@angular/router';
import { Observable } from 'rxjs';
import { AuthService } from './auth.service';
import jwt_decode from "jwt-decode";

@Injectable({
  providedIn: 'root'
})
export class RoleGuard implements CanActivate {
  constructor(private authService: AuthService, private router: Router) { }

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): boolean {
    const expectedRole = route.data.expectedRole;
    const role = this.authService.getUserRole();
    if (role) {
      if (role !== expectedRole) {
        this.router.navigate(['/not-found']);
        return false;
      }
      return true; 
    }
    this.router.navigate(['/login']);
    return false;
  }
}
