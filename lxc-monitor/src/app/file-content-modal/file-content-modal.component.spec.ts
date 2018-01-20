import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { FileContentModalComponent } from './file-content-modal.component';

describe('FileContentModalComponent', () => {
  let component: FileContentModalComponent;
  let fixture: ComponentFixture<FileContentModalComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ FileContentModalComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FileContentModalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
