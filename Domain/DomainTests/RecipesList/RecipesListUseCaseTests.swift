//
//  RecipesListUseCaseTests.swift
//  Domain
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import XCTest
@testable import Domain

final class RecipesListUseCaseTests: XCTestCase {

    var sut: RecipesListUseCase!
    var viewModelSpy: RecipesListViewModelSpy!
    var repositorySpy: RecipesListRepositorySpy!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupRecipesListUseCase()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        viewModelSpy = nil
        repositorySpy = nil
    }

    // MARK: Test setup

    func setupRecipesListUseCase() {
        viewModelSpy = RecipesListViewModelSpy()
        repositorySpy = RecipesListRepositorySpy()
        sut = RecipesListUseCase(repository: repositorySpy)
        sut.delegate = viewModelSpy
    }

    // MARK: - Tests

    func test_fetchRecipes_Success() {

        //Given
        repositorySpy.requestFailed = false
        let expectation = XCTestExpectation(description: "Esperar a que fetchRecipes sea llamado")

        //When
        sut.fetchRecipes()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {

            // Then
            XCTAssertTrue(self.repositorySpy.fetchRecipesCalled, "fetchRecipes deberia ser llamado")
            XCTAssertTrue(self.viewModelSpy.reloadRecipesCalled, "reloadRecipesCalled deberia ser llamado")
            XCTAssertFalse(self.viewModelSpy.handleErrorCalled, "handleErrorCalled no deberia ser llamado")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func test_fetchRecipes_Failed() {

        //Given
        repositorySpy.requestFailed = true
        let expectation = XCTestExpectation(description: "Esperar a que fetchRecipes sea llamado")

        //When
        sut.fetchRecipes()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {

            // Then
            XCTAssertTrue(self.repositorySpy.fetchRecipesCalled, "fetchRecipes deberia ser llamado")
            XCTAssertFalse(self.viewModelSpy.reloadRecipesCalled, "reloadRecipesCalled no deberia ser llamado")
            XCTAssertTrue(self.viewModelSpy.handleErrorCalled, "handleErrorCalled deberia ser llamado")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

}
