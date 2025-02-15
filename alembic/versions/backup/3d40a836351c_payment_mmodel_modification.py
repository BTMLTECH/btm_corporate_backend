"""Payment mmodel modification..

Revision ID: 3d40a836351c
Revises: f69f20808d5c
Create Date: 2025-01-02 19:10:54.523181

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa
from app.model.personal_package_payment import PackagePaymentStatusTypeEnum
from app.model.tour_package import TourPackagePaymentStatusTypeEnum


# revision identifiers, used by Alembic.
revision: str = '3d40a836351c'
down_revision: Union[str, None] = 'f69f20808d5c'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    PackagePaymentStatusTypeEnum.create(op.get_bind(), checkfirst=True)
    TourPackagePaymentStatusTypeEnum.create(op.get_bind(), checkfirst=True)
    op.drop_constraint('tour_packages_payment_id_fkey', 'tour_packages', type_='foreignkey')
    op.drop_column('tour_packages', 'payment_id')
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('tour_packages', sa.Column('payment_id', sa.UUID(), autoincrement=False, nullable=True))
    op.create_foreign_key('tour_packages_payment_id_fkey', 'tour_packages', 'personal_package_payment', ['payment_id'], ['id'])
    PackagePaymentStatusTypeEnum.drop(op.get_bind(), checkfirst=True)
    TourPackagePaymentStatusTypeEnum.drop(op.get_bind(), checkfirst=True)
    # ### end Alembic commands ###
