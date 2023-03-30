import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PopUpConfirmDeletePlayerComponent } from './pop-up-confirm-delete-player.component';

describe('PopUpConfirmDeletePlayerComponent', () => {
  let component: PopUpConfirmDeletePlayerComponent;
  let fixture: ComponentFixture<PopUpConfirmDeletePlayerComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PopUpConfirmDeletePlayerComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PopUpConfirmDeletePlayerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
