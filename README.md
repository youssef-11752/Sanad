**Sanad – Service Marketplace Mobile Application**

**Project Overview**

Sanad is a mobile-based Service Marketplace platform designed to connect customers with professional service providers through a centralized and easy-to-use application.

The platform supports two primary user roles: Customers and Service Providers, with an Admin role responsible for managing and overseeing the platform.

Customers can browse available service categories, select the required service, describe their problems, provide their location, and choose a suitable appointment date and time. Once submitted, each service request receives a unique Request ID and becomes available to relevant service providers.

Service Providers can manage their service offerings, review incoming requests, organize customer information, and update request statuses throughout the service lifecycle.

The app uses the device locale.

## Supabase

The requests screen loads the signed-in user's `pending` and `fulfilled` rows
from the `orders` table. Supply the Supabase project URL and publishable key at
runtime:

```sh
fvm flutter run \
  --dart-define=SUPABASE_URL=https://YOUR_PROJECT_ID.supabase.co \
  --dart-define=SUPABASE_PUBLISHABLE_KEY=YOUR_PUBLISHABLE_KEY
```

The app also requires an authenticated Supabase session. Keep the `orders`
table protected with row-level security; never use a service-role key in the
client app.

### Existing Sanad auth schema

The Flutter auth flow uses the existing `public.users` and
`public.user_types` tables shown in the Supabase schema:

- `users.id` links the profile to `auth.users.id`.
- `users.user_type_id` links to `user_types.id`.
- `users.full_name`, `email`, `phone`, and `profile_image` hold the profile fields.
- Login reads the role through the `users -> user_types` relationship. It does
  not trust the editable `auth.users.raw_user_meta_data.role` value.

Before testing new registrations, open the Supabase SQL Editor and run
`supabase/migrations/20261115040000_auth_profiles_and_role_lookup.sql`.
The migration installs a signup trigger that creates the matching
`public.users` row, enables RLS on `users` and `user_types`, permits users to
read only their own profile, and permits authenticated role-name lookup.

The `user_types.name` column must contain one customer type and one provider
type. Accepted customer labels are `customer`, `client`, `محتاج خدمة`,
`محتاج خدمه`, or `عميل`. Accepted provider labels are `provider`,
`service provider`, `مقدم الخدمة`, or `مقدم خدمه`. The trigger resolves
the numeric `user_type_id` from those names; it does not assume fixed IDs.

The current sign-up form also collects city and area as text. Those values are
kept in auth metadata for now because the existing schema uses numeric
`city_id`/country references and needs a proper city selector before those
fields can safely be written to relational tables. Provider specialty and
verification remain separate provider-profile work.

The reference screens show phone/SMS verification, while the current auth UI
still uses email/password and email recovery. SMS authentication is not enabled
by this change; it requires the project's phone-auth/SMS provider and matching
UI flow to be configured and tested.

## Flutter SDK version

This project uses Flutter 3.50.0 stable with Dart 3.14.0, pinned in `.fvmrc`.
Install [FVM](https://fvm.app/) and run:

```sh
fvm install
fvm flutter pub get
fvm flutter test
```

GitHub Actions reads the same version from `.fvmrc` and runs the tests and web
build for pushes and pull requests targeting `develop`.

**Core Modules – Phase 1**

1. **User Authentication & Profile Management:** Registration, login, password recovery, user profiles, and role management.
2. **Provider Dashboard:** Overview of incoming requests, pending, confirmed, in-progress, and completed requests, along with upcoming appointments.
3. **Customer Management:** Access customer information, previous service requests, and customer history.
4. **Service Management:** Allow providers to create, update, and manage their services, including descriptions and estimated prices.
5. **Service Request Management:** Enable customers to submit service requests with categories, problem descriptions, locations, and preferred appointments, generating a unique Request ID for each request.
6. **Request Status Management:** Enable providers to manage request statuses, including Pending, Confirmed, In Progress, Completed, and Cancelled.

**Project Scope**

Phase 1 focuses on delivering the core marketplace workflow, allowing customers to request services and service providers to receive, manage, and complete those requests through one integrated platform.

Phase 2 will cover deferred advanced capabilities, including online payment management, advanced customer request tracking, notifications, appointment reminders, PDF invoices, and reports.

**Technology & Project Management**

- Mobile Application: Flutter
- Version Control: Git
- Project Management & Collaboration: Microsoft Azure DevOps

**Project Objective**

To build a reliable and organized service marketplace that simplifies service discovery and request creation for customers while providing service providers with the essential tools to manage their services, customers, and requests efficiently.
