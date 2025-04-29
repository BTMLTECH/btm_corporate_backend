from app.model.user import User, UserVerification
from app.model.google import GoogleVerification
from app.model.region import Region
from app.model.activity import Activity
from app.model.accommodation import Accommodation
from app.model.transportation import Transportation
from app.model.tour_sites_region import TourSitesRegion
from app.model.user_tour_package import UserTourPackage
from app.model.user_tour_package_activity import UserTourPackageActivityLink
from app.model.user_tour_package_tour_sites_region import (
    UserTourPackageTourSitesRegionLink,
)
from app.model.user_tour_package_transportation import UserTourPackageTransportationLink
from app.model.user_payment import UserPayment
from app.model.user_tour_package_payment import UserTourPackagePaymentLink
from app.model.destination import Destination
from app.model.tour_package import TourPackage
from app.model.itinerary import Itinerary
from app.model.destination_tour_package import DestinationTourPackageLink
from app.model.inclusion import Inclusion
from app.model.exclusion import Exclusion
from app.model.terms_condition import TermsCondition