#!/usr/bin/env python3
# File: region.py
# Author: Oluwatobiloba Light
"""Region endpoint"""


from typing import Sequence, Union
from uuid import UUID
from dependency_injector.wiring import Provide, inject
from fastapi import APIRouter, Depends
from fastapi.encoders import jsonable_encoder
from app.core.dependencies import is_user_admin
from app.core.exceptions import GeneralError
from app.model.region import Region
from app.model.tour_sites_region import TourSitesRegion
from app.model.user import User
from app.schema.region_schema import CreateRegion, RegionSchema, UpdateRegion
from app.schema.tour_sites_region_schema import CreateTourSitesRegion, TourSitesRegionSchema, UpdateTourSitesRegion
from app.services.region_service import RegionService
from app.core.container import Container
from app.services.tour_sites_service import TourSitesRegionService


router = APIRouter(
    prefix="/region",
    tags=["Region"],

)


@router.post("/add", response_model=Region)
@inject
async def add_region(region: CreateRegion, service: RegionService = Depends(Provide[Container.region_service]), current_user: User = Depends(is_user_admin)):
    """Route to add a region"""
    region = await service.add(region)

    return region


@router.get("/tour-sites", response_model=Sequence[TourSitesRegionSchema],
            description="Get a list of all Tourist sites in all Regions",
            )
@inject
async def get_all_tour_sites(service: TourSitesRegionService = Depends(Provide[Container.tour_sites_region_service])):
    """Route to get a list of all tour sites in all regions"""
    regions = await service.get_all_tour_sites()

    return regions


@router.delete("/{region_id}")
@inject
async def delete_region(region_id: str, service: RegionService = Depends(Provide[Container.region_service]), current_user: User = Depends(is_user_admin)):
    """Route to delete a region by id"""
    region = await service.delete_by_id(region_id)

    if not region:
        raise GeneralError(detail="Region has been deleted or does not exist")

    return region


@router.get("", response_model=Sequence[RegionSchema],
            description="Get a list of all regions",
            )
@inject
async def get_all_regions(service: RegionService = Depends(Provide[Container.region_service])):
    """Route to get a list of all regions"""
    regions = await service.find_all_regions()

    return regions


@router.get("/{region_id}", response_model=RegionSchema, description="Get a region by ID")
@inject
async def get_region_by_id(region_id: str, service: RegionService = Depends(Provide[Container.region_service])):
    """Route to get a region by ID"""
    return await service.find_by_id(region_id)


@router.patch("/{region_id}", response_model=Union[RegionSchema, None])
@inject
async def update_region_by_id(region_id: str, updated_region: UpdateRegion, service: RegionService = Depends(Provide[Container.region_service])):
    """Route to update a region by ID"""
    return await service.update_by_id(region_id, updated_region)


@router.post("/add/tour-sites", response_model=TourSitesRegionSchema)
@inject
async def create_region_tour_site(tour_site: CreateTourSitesRegion, service: TourSitesRegionService = Depends(Provide[Container.tour_sites_region_service])):
    """Create a tour site in a region"""
    tour_site = await service.add(tour_site)

    return tour_site


# @router.get("/{region_id}/tour-sites", response_model=Sequence[TourSitesRegionSchema], description="Get all tour sites in a region")
# @inject
# async def get_region_tour_sites(region_id: str, service: TourSitesRegionService = Depends(Provide[Container.tour_sites_region_service])):
#     """Route to get all tour sites of a region"""
#     tour_sites = await service.find_all_tour_sites_by_region(region_id)

#     return tour_sites


@router.get("/tour-sites/{tour_site_id}", response_model=Union[TourSitesRegionSchema, None], description="Get a tour site by ID")
@inject
async def get_tour_site_by_id(tour_site_id: str, service: TourSitesRegionService = Depends(Provide[Container.tour_sites_region_service])):
    """Route to get a tour site by ID"""
    tour_site = await service.get_by_id(tour_site_id)

    return tour_site


@router.patch("/tour-site/{tour_site_id}", response_model=TourSitesRegionSchema, description="Route to update a tour site")
@inject
async def update_tour_site_by_id(tour_site_id: str, update_tour_site: UpdateTourSitesRegion, service: TourSitesRegionService = Depends(Provide[Container.tour_sites_region_service])):
    """Route to update a tour site by id"""
    return await service.update_by_id(tour_site_id, update_tour_site)


@router.delete("/tour-site/{tour_site_id}", response_model=None, description="Delete a tour site")
@inject
async def delete_tour_site_by_id(tour_site_id: str, service: TourSitesRegionService = Depends(Provide[Container.tour_sites_region_service])):
    """Route to delete a tour site by id"""
    tour_site = await service.delete_by_id(tour_site_id)

    if not tour_site:
        raise GeneralError(
            detail="Tour site has been deleted or does not exist")

    return tour_site
