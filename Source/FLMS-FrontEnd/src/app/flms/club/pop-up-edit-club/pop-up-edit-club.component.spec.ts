import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PopUpEditClubComponent } from './pop-up-edit-club.component';

describe('PopUpEditClubComponent', () => {
  let component: PopUpEditClubComponent;
  let fixture: ComponentFixture<PopUpEditClubComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PopUpEditClubComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PopUpEditClubComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
