"""Payment mmodel

Revision ID: b7a376d0738a
Revises: 3672b5d7eb5d
Create Date: 2024-12-29 12:43:09.760738

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'b7a376d0738a'
down_revision: Union[str, None] = '3672b5d7eb5d'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint('tour_packages_accommodation_id_fkey', 'tour_packages', type_='foreignkey')
    op.create_foreign_key(None, 'tour_packages', 'accommodations', ['accommodation_id'], ['id'])
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint(None, 'tour_packages', type_='foreignkey')
    op.create_foreign_key('tour_packages_accommodation_id_fkey', 'tour_packages', 'accommodations', ['accommodation_id'], ['id'], ondelete='CASCADE')
    # ### end Alembic commands ###
