import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { MainComponent } from './layouts/main/main.component';
import { NavbarComponent } from './layouts/navbar/navbar.component';
import { FooterComponent } from './layouts/footer/footer.component';
import { VerticalMenuComponent } from './layouts/vertical-menu/vertical-menu.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatSidenavModule } from "@angular/material/sidenav";
import { MatListModule } from "@angular/material/list";
import { MatButtonModule } from "@angular/material/button";
import { MatIconModule } from "@angular/material/icon";
import { MatExpansionModule } from '@angular/material/expansion';
import { FlmsModule } from './flms/flms.module';
import { GuestViewModule } from './guest-view/guest-view.module';
import { MatMenuModule } from '@angular/material/menu';
import { HttpClientModule } from '@angular/common/http';
import { MatCardModule } from '@angular/material/card';
import { AngularFireModule } from '@angular/fire';
import { environment } from "../environments/environment";
import { AngularFireAuthModule } from '@angular/fire/auth';
import { MatSnackBarModule } from '@angular/material/snack-bar';

@NgModule({
  declarations: [
    MainComponent,
    NavbarComponent,
    FooterComponent,
    VerticalMenuComponent
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    MatSidenavModule,
    MatListModule,
    MatMenuModule,
    MatCardModule,
    MatIconModule,
    MatButtonModule,
    MatSnackBarModule,
    MatExpansionModule,
    FlmsModule,
    GuestViewModule,
    AppRoutingModule,
    HttpClientModule,
    AngularFireModule.initializeApp(environment.firebaseConfig),
    AngularFireAuthModule
  ],
  providers: [],
  bootstrap: [MainComponent]
})
export class AppModule { }
